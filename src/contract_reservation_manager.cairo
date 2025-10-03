use starknet::ContractAddress;
use core::integer::u64;

use contracts::contract_apartment_registry::{
    IApartmentRegistryDispatcher,
    IApartmentRegistryDispatcherTrait,
    Apartment
};

#[derive(Drop, starknet::Store, Serde)]
pub struct Reservation {
    pub apartment_id: u64,
    pub start_date: u64,
    pub end_date: u64,
    pub reserver: ContractAddress,
}

#[starknet::interface]
pub trait IReservationManager<TContractState> {

    fn reserve_apartment(
        ref self: TContractState,
        apartment_id: u64,
        start_date: u64,
        end_date: u64,
    );

    fn get_reservations(self: @TContractState, apartment_id: u64) -> Array<Reservation>;
}

#[starknet::contract]
pub mod ReservationManager {
    use super::*;
    use starknet::ContractAddress;
    use starknet::storage::*;
    use starknet::get_caller_address;
    use core::integer::u64;
    use core::array::ArrayTrait;
    use core::option::OptionTrait;

    #[storage]
    pub struct Storage {
        reservations_by_apartment: Map<u64, Vec<Reservation>>,
        apartment_registry: ContractAddress,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        ApartmentReserved: ApartmentReserved,
    }

    #[derive(Drop, starknet::Event)]
    pub struct ApartmentReserved {
        pub apartment_id: u64,
        pub start_date: u64,
        pub end_date: u64,
        pub reserver: ContractAddress,
    }

    #[constructor]
    fn constructor(ref self: ContractState, registry_address: ContractAddress) {
        self.apartment_registry.write(registry_address);
    }

    #[abi(embed_v0)]
    pub impl ReservationManagerImpl of super::IReservationManager<ContractState> {

        fn reserve_apartment(
            ref self: ContractState,
            apartment_id: u64,
            start_date: u64,
            end_date: u64,
        ) {
            let reserver = get_caller_address();

            let registry = IApartmentRegistryDispatcher { contract_address: self.apartment_registry.read() };
            let apartment: Apartment = registry.get_apartment(apartment_id);

            assert!(apartment.apartment_id != 0, "Apartment does not exist");

            assert!(apartment_id != 0, "Apartment ID must be non-zero");
            assert!(start_date < end_date, "Start date must be before end date");

            let reservations_vec = self.reservations_by_apartment.entry(apartment_id);
            let len = reservations_vec.len();

            for i in 0..len {
                let existing_reservation = reservations_vec.at(i).read();

                assert!(
                    !(start_date < existing_reservation.end_date 
                        && end_date > existing_reservation.start_date),
                    "Requested period overlaps with existing reservation"
                );
            };

            let new_reservation = Reservation {
                apartment_id,
                start_date,
                end_date,
                reserver,
            };

            reservations_vec.append().write(new_reservation);

            self.emit(
                Event::ApartmentReserved(
                    ApartmentReserved {
                        apartment_id,
                        start_date,
                        end_date,
                        reserver,
                    }
                )
            );
        }

        fn get_reservations(self: @ContractState, apartment_id: u64) -> Array<Reservation> {
            let reservations_vec = self.reservations_by_apartment.entry(apartment_id);
            let len = reservations_vec.len();
            let mut all_reservations = array![];

            // Copia todas as reservas existentes para retornar
            for i in 0..len {
                all_reservations.append(reservations_vec.at(i).read());
            };
            all_reservations
        }
    }
}
