[BACK](../check_documentation.md)

# Number of Public Attributes Check
## What is the Intent of the Check?
The Number of Public Attributes Check counts the number of public attributes up to a maximum (usually 0). All attributes and methods should be private by default. The {data encapsulation principle](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)) helps you to protect your attributes from being changed and adds readability for others, they only see what they need.

## How does the check work?
This Check counts only `DATA` and `CLASS-DATA` within a global or local, `CLASS DEFINITION` or `INTERFACE`. Inherited attributes and `CONSTANTS` aren't counted. A structure is counted as one attribute, no matter how many attributes are in the structure.

## Which attributes can be maintained?
![Attributes](./img/number_of_public_attributes.png)

## How to solve the issue?
Make those attributes `PRIVATE` or `PROTECTED`. You can grant the read access with a getter method (for example, `get_user_first_name`). With a setter, you can also grant write access and have the possibility to validate the inserted data (for example, `set_time_in_seconds` with a test to allow only positive numbers).

## What to do in case of exception?
You can suppress Code Inspector findings generated by this check using the pseudo comment `"#EC NUM_PUBLIC_ATTR`. The pseudo comment must be placed right after the class definition header.

### Example
```abap
CLASS class_name DEFINITION.   "#EC NUM_PUBLIC_ATTR
  PUBLIC SECTION.
    DATA attribute1 TYPE i.
    DATA attribute2 TYPE i.
ENDCLASS.
```
