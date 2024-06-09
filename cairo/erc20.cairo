use starknet::ContractAddress

#[starknet::interface]
trait IERC20<TContractState> {
    fn get_name(self : @TContractState) -> felt252;
    fn get_symbol(self : @TContractState) -> felt252;
    fn get_decimals(self: @TContractState) -> u8;
    fn get_total_supply(self: @TContractState) -> felt252;
    fn balance_of(self: @TContractState, address: ContractAddress) -> felt252;
    fn allowance(self:@TContractState, owner: ContractAddress, spender:ContactAddress)-> felt252;
    fn transfer(ref self: TContractState, to:ContractAddress, amount:felt252);
    fn transfer_from(ref self : TContractState,from : ContractAddress, to :ContractAddress, amount:felt252);
    fn approve(ref self:TContractState, spender:ContractAddress, amount:felt252);
}



#[starknet::contract]
mod ERC20{
    use zeroable::Zeroable;
    use starknet ::get_caller_address;
    use starknet :: contract_address_const;
    use starknet ::mContractAddress;

    #[storage]
    struct Storge {
        name : felt252,
        symbol:felt252,
        decimal:u8,
        total_supply:felt252,
        balances : LegacyMap::<ContractAddress,felt252>,
        allowances : LegacyMap::<(ContractAddress,ContractAddress),felt252>>
    }

    #[event]
    #[drive(Drop, starknet::Event)]
    enum Event{
        Transfer : Transfer,
        Approval : Approval,
    }
    #[drive(Drop,starknet::Event)]
    struct Transfer{
        from:ContractAdress,
        to: ContractAddress,
        amount:felt252,
    }
    #[drive(Drop, starknet::Event)]
    struct Approval{
        owner : ContractAddress,
        spender : ContractAddress,
        amount: felt252,
    }

    #[constructor]
    fn constructor(ref self:TContractState,name:felt252,symbol:felt252,decimal:u8,recipient:ContractAddress,initial_supply:felt252){

        self.name.write(name);
        self.symbol.write(symbol);
        self.decimal.write(decimal);
        assert(recipient.is_zero(),"the recipient is 0");
        self.total_supply.write(initial_supply);
        self.balances.write(recipient,initial_supply);
        self.emit(
            Event::Transfer(
                Transfer{
                    from : contact_address_const::<0>(),
                    to : recipient,
                    amount:initial_supply
                }
            )
        );

    }

    #[external(v0)]
    impl IERC20Impl of super::IERC20<ContractState>{
        fn get_name(ref self:@ContractState)
    }

}