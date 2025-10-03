use starknet::ContractAddress;

#[starknet::interface]
pub trait IApartmentRegistry<TContractState> {
    
    fn register_apartment(ref self: TContractState, apartment_id: u64, price: u256, owner_id: ContractAddress);

    fn get_apartment(self: @TContractState, apartment_id: u64) -> Apartment;

}

#[derive(Drop, starknet::Store, Serde)]
pub struct Apartment {
    pub apartment_id: u64,
    pub price: u256,
    pub owner_id: ContractAddress

}

#[starknet::contract]
pub mod ApartmentRegistry {

    use super::*;
    use starknet::ContractAddress;
    use starknet::storage::*;
    use starknet::get_caller_address;
    use super::Apartment;

    #[storage]
    struct Storage {
        apartments: Map<u64, Apartment>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        ApartmentRegistered: ApartmentRegistered,
    }

    #[derive(Drop, starknet::Event)]
    pub struct ApartmentRegistered {
        pub apartment_id: u64,       
        pub price: u256, 
        pub owner_id: ContractAddress,  
        pub registered_by: ContractAddress,
    }


    #[abi(embed_v0)]
    pub impl ApartmentRegistryImpl of super::IApartmentRegistry<ContractState> {
        

        fn register_apartment(
            ref self: ContractState, 
            apartment_id: u64, 
            price: u256, 
            owner_id: ContractAddress
        ) {

            let caller = get_caller_address();

            let new_apartment = Apartment {
                apartment_id,
                price,
                owner_id,
            };

            self.apartments.entry(apartment_id).write(new_apartment);

            self.emit(Event::ApartmentRegistered(
                ApartmentRegistered {
                    apartment_id,
                    price,
                    owner_id,
                    registered_by: caller,
                }
            ));
        }


        fn get_apartment(
            self: @ContractState,
            apartment_id: u64
        ) -> Apartment {
            self.apartments.entry(apartment_id).read()
        }
    }
}


