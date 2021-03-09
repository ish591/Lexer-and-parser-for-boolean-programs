# COL226 Assignment 2

Lexing and parsing of boolean expressions

## Testing

### Building

```bash
cd 2019CS10359   #required directory
make        # compiles the lex and yacc files using mllex and mlyacc, then compiles a2.mlb using mlton to generate the executable a2
```

### Running the executable

```bash
./a2 input.txt # To run a2 on the input file input.txt
```

### Removing the sml, signature, description and executable files

```bash
make clean      # To clean the build and runtime files.
```
