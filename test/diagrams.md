# Diagrams

## Plant UML

```plantuml
Bob -> Alice : hello
```

## JS Sequence Diagrams

```sequence-diagrams
Bob -> Alice : Says
Note right of Alice: Bob thinks
Alice --> Andrew: How are you?
Andrew ->> Alice: I'm OK
```

## Flowchart

```flowchart
st=>start: Start|past
e=>end: End|future
op1=>operation: My Operation|past
op2=>operation: Stuff|current
sub1=>subroutine: My Subroutine|invalid
cond=>condition: Yes
or No?|approved:>http://www.google.com
c2=>condition: Good idea|rejected
io=>inputoutput: catch something...|future

st->op1(right)->cond
cond(yes, right)->c2
cond(no)->sub1(left)->op1
c2(yes)->io->e
c2(no)->op2->e
```
