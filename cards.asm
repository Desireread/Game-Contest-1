; Code for poker game

;Code to initialize file
.386
.model flat, stdcall
Include Irvine32.inc


;Macro to randomly assign nunCards amount of cards to a given deck
shuffle MACRO givenDeck, numCards
  mov ecx, 0                  ;Count number of cards in player's deck
  mov edx, deckCount                 ;Count number of cards left in regular deck
  addCards:                    
    call Randomize            ;Get a random card from deck using randomize to get a random number
    mov eax, edx
    call RandomRange
    mov ebx, deck[eax*4]      ;Move random card to ebx
    mov givenDeck[ecx*4], ebx      ;Add random card from deck (in ebx) to position ecx in given deck
    ;Input operation to remove card from deck
    removeCards deck, eax
    inc ecx                   ;increment ecx (number of cards in given deck)
    cmp ecx, numCards         ;Check if givenDeck contains the right about of cards
    jl addCards               ;Jump back to beginning of loop of givenDeck has less than numCards amount of cards
    dec edx                   ;subtract the amount of cards that are in deck
  mov deckCount, edx          ;Update the value for the number of cards left in the deck
ENDM

;Macro to delete a card from a deck
removeCards MACRO givenDeck, addr        ;Define the macro
  mov ecx, LENGTHOF givenDeck            ;Assign the length of the given deck to ecx
  mov eax, addr                          ;Assign the starting address to eax
  delete: 
    cmp eax, ecx                         ;Check if the given address is the last element
    je end                               ;If element is the last one on the deck, jmp to end
    mov ebx, givenDeck[(eax+1)*4]        ;Assign the value of the next element in the givenDeck to ebx
    mov givenDeck[eax*4], ebx            ;Move the next element to the current position
    inc eax                              ;increment eax to the next position
    jmp delete                           ;Jump back to the beginning of the loop
  end:
    mov givenDeck[eax*4], " "            ;Assign an empty value to the last element
ENDM

;Check the amount of elements in an array
deckSize MACRO givenDeck
  mov ecx, 0                             ;Start at 0
  checkSize:                             ;Loop to check how many elements are in the array
    mov edx, [givenDeck[ecx*4]]          ;Assign the element int he current address to edx
    cmp edx, " "                        ;Check if the current element is "emtpy"
    jne end                              ;Jump out of th eloop is the elemnt is empty
    inc ecx                              ;Increase the number of elemnts found in the deck
    jmp checkSize                        ;jump to beginning  of loop
  end:
ENDM

printDeck MACRO givenDeck, size          ;Macro to print the given deck
  mov ecx, 0                             ;assign 0 to ecx
  print:                                 ;Printing loop
    mov edx, givenDeck[ecx*4]            ;Assign the value of the current element to edx
    call WriteString                     ;Print the current element to the console
    mov edx, ' '                         ;Add a space between each element
    call WriteString                  
    inc ecx                              ;Point to the next element
    cmp ecx, size                        ;Check if ecx is more then the size of the array                          
    jle print                            ;Jmp to start of loop if ecx is less than or equal to the size of the array
    call crlf                            ;Move to a new line
ENDM

.data
; Create list containing cards
deck DWORD "1h", "2h", "3h","4h","5h","6h","7h","8h","9h","10h","jh","qh","kh","ah","1d","2d","3d","4d","5d","6d","7d","8d","9d","10d","jd","qd","kd","ad","1c","2c","3c","4c","5c","6c","7c","8c","9c","10c","jc","qc","kc","ac","1s","2s","3s","4s","5s","6s","7s","8s","9s","10s","js","qs","ks","as"
deckCount DWORD 52
; Create list for player deck
playerDeck DWORD 52 DUP(?)
; Create list for computer deck
compDeck DWORD 52 DUP(?)
cardSearch BYTE "What number do you want to look for?", 0             ;Prompt for GOFish player
inputReminder BYTE "Input format: 1-9 for a number; jack = j, queen = q, king = k, ace = a", 0


.code
main PROC
;Add a procedure for "I declare war"
shuffle playerDeck, 25
shuffle compDeck, 25


;Add a procedure for go fish
shuffle playerDeck, 7
shuffle compDeck, 7

;Print deck to the board (macro?)
printDeck playerDeck, 7
;Player types in the number they are looking for
mov edx, inputReminder
call WriteString
call crlf
mov edx, cardSearch
call WriteString



;Computer either hadns over cards or says go fish
  ;Function checks all elements in computer deck and hands over cards or says go fish
  ;After function, the cards the player recieves is displayed
  ;Player can check for a match of 4
    ;if match is found, player point increases

;Compuetr's turn to play
    ;Random number from compDeck's size if chose
    ;Computer asks for number/letter
    ;If player has matching cards, those cards will be surrenedered to computer's deck
      ;This transaction will be displayed
    ;Computer's deck will be checked for macthes of 4
      ;If match is found, computer point increases

;Add a procedure for blackjack
  ;Extra
;Procedure for checking a value
;checkValue Proc
main ENDP
END main
