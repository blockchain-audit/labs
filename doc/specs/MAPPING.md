## Business Requirements for TestIterableMap Smart Contract

**1. User Roles:**

* **Deployer:** Entity deploying the contract and initializing the `IterableMapping`.
* **User:** Entity interacting with the contract by adding, removing, or querying elements in the `IterableMapping`.

**2. User Stories:**

**2.1 Deployer:**

**2.1.1 Deploy Contract:**

* **Pre-state:** N/A
* **Post-state:**
    * Contract deployed successfully on the blockchain.
    * `IterableMapping` instance initialized with an empty state.
* **Acceptance Criteria:**
    * Contract deployment succeeds without errors.
    * `IterableMapping` is accessible within the contract.

**2.2 User:**

**2.2.1 Add Element:**

* **Pre-state:**
    * User has an address and a uint value.
    * `IterableMapping` exists in the contract.
* **Post-state:**
    * Element (key-value pair) added to the `IterableMapping`.
    * `keys` array updated to include the new key.
    * `values` mapping updated with the new value for the key.
    * `indexOf` mapping updated to reflect the new key's position.
    * `inserted` mapping updated to mark the key as inserted.
* **Mathematical Formula:**
    * Addition of elements to an array and mappings.
* **Pseudocode:**
    ```python
    def add_element(address key, uint value):
        if key not in mapping:
            mapping.keys.append(key)
            mapping.values[key] = value
            mapping.indexOf[key] = len(mapping.keys) - 1
            mapping.inserted[key] = True
        else:
            mapping.values[key] = value
    ```
* **Acceptance Criteria:**
    * The element is added successfully to the `IterableMapping`.
    * The state of the `keys`, `values`, `indexOf`, and `inserted` mappings is updated correctly.

**2.2.2 Remove Element:**

* **Pre-state:**
    * User has an address of an existing element.
    * `IterableMapping` exists in the contract and contains the element.
* **Post-state:**
    * Element removed from the `IterableMapping`.
    * `keys` array updated to remove the key.
    * `values` mapping updated to delete the value for the key.
    * `indexOf` mapping updated to reflect the removal.
    * `inserted` mapping updated to mark the key as not inserted.
    * Last element in the `keys` array moved to the removed element's position.
* **Mathematical Formula:**
    * Removal of elements from an array and mappings.
* **Pseudocode:**
    ```python
    def remove_element(address key):
        if key in mapping:
            del mapping.values[key]
            del mapping.inserted[key]
            index = mapping.indexOf[key]
            last_key = mapping.keys[-1]
            mapping.indexOf[last_key] = index
            del mapping.indexOf[key]
            mapping.keys[index] = last_key
            del mapping.keys[-1]
    ```
* **Acceptance Criteria:**
    * The element is removed successfully from the `IterableMapping`.
    * The state of the `keys`, `values`, `indexOf`, and `inserted` mappings is updated correctly.

**2.2.3 Get Element Value:**

* **Pre-state:**
    * User has an address of an existing element.
    * `IterableMapping` exists in the contract and contains the element.
* **Post-state:**
    * User obtains the value associated with the address.
* **Mathematical Formula:**
    * Lookup of a value in a mapping.
* **Pseudocode:**
    ```python
    def get_element_value(address key):
        if key in mapping:
            return mapping.values[key]
        else:
            return None
    ```
* **Acceptance Criteria:**
    * The function returns the correct value associated with the address, or None if the address is not present.

**2.2.4 Get Element at Index:**

* **Pre-state:**
    * User has an index within the valid range of the `keys` array.
    * `IterableMapping` exists in the contract.
* **Post-state:**
    * User obtains the address of the element at the specified index.
* **Mathematical Formula:**
    * Accessing an element in an array.
* **Pseudocode:**
    ```python
    def get_element
