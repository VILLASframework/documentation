# Contribution guidelines

## Coding style

### Naming

- Variables should use lower case names with underscores.
- There are now special visibility or type prefixes.
- Structure members should not use abbreviated names:

Good
```cpp
struct A {
    char *message;
    int length;
}
```

Bad:
```cpp
struct A {
    char *msg;
    int len;
}
```

### Placement of spaces

In variable declarations (including in function parameters) we place the asterisk next to the variable name.

Good:
```cpp
int *number;
```

Bad:
```cpp
int * number;
int* number;
```

In function return values we place the asterisk between spaces

Good:
```cpp
void * my_thread()
{
    
}
```

Bad:
```cpp
void *mythread()
{
    
}

void * mythread()
{
    
}
```

In expressions we place spaces between most elements but not between parantheses:

Good:
```cpp
int a = ((5 * 10) + 10 ) % 22;
```

Bad:
```cpp
int a = ((5*10)+10)%22;
```

We also put spaces in front / after most keywords such as `if`, `while`, ...

Good:
```cpp
for (int a = 0; a < 1; a++) {
    ...
}
```

Bad:
```cpp
for(int a = 0; a < 1; a++) {
    ...
}
```

### Line length

Try to limit line length to about 160 characters.

### Indention

We use tabs for indention which should be displayed as 8 spaces by your editor.

### Brace placement

For everything except functions we place the opening brace in the same line:

Good:
```cpp
struct A {
    enum {
        A,
        B
    } choice;
}

if (true) {
    
}
```

Bad:
```cpp
struct A
{
    enum
    {
        A,
        B
    } choice;
}

if (true)
{
    
}
```

However, in functions we place the brace in a new line:

```cpp
void main()
{
    
}
```

### #define and Macro Names

Are always written in `UPPERCASE`.

Good:
```cpp
#define HUGEPAGESIZE (1 << 22)
#define MAX(a, b) (a > b ? a ? b)
```

Bad:
```cpp
#define max(a, b) (a > b ? a ? b)
```

## Always work on feature branches

Please branch from `develop` to create a new _feature_ branch.

Please create a new _feature_ branch for every new feature or fix.

## Make the CI happy :-)

Only branches which pass the CI can be merged.
