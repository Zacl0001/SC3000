% Facts
competitor(sumsum, appy).
developed(sumsum, galactica_s3).
smart_phone_tech(galactica_s3).
stolen(stevey, galactica_s3).
boss(stevey, appy).

% Rules
rival(X, Y) :- competitor(X, Y).
business(X) :- smart_phone_tech(X).

unethical(B) :- 
    boss(B, C), 
    rival(R, C), 
    business(X), 
    developed(R, X), 
    stolen(B, X).