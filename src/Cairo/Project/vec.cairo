use array::ArrayTrait;

#[derive(Copy, Drop)]
struct Employee {
    age: u8,
    id: u32,
    role: felt252,
}

#[derive(Drop)]
struct Company {
    employees: Array<Employee>,
    number_of_buildings: u32
}

fn main() {
    let employee = Employee {
        age: 53,
        id: 1616,
        role: 'engineer',
    };
    let mut employees = ArrayTrait::new();
    employees.append(employee);

    let number_of_buildings = 53;

    let company = Company {
        number_of_buildings,
        employees,
    };
}