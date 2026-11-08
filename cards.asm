; Code for poker game

;Code to initialize file
.386
.model flat, stdcall
Include Irvine32.inc


;Macro to randomly assign nunCards amount of cards to a given deck
shuffle MACRO givenDeck, numCards
  mov ecx, 0                  ;Count number of cards in players deck
  ;mov edx, deckCount                 ;Count number of cards left in regular deck
  lea edx, givenDeck
  addCards:                    
    call Randomize            ;Get a random card from deck using randomize to get a random number
    mov eax, deckCount
    call RandomRange
    lea edx,deck
    mov ebx, deck[edx+eax*3]      ;Move random card to ebx
    lea edx, givenDeck
    mov givenDeck[edx+ecx*3], ebx      ;Add random card from deck (in ebx) to position ecx in given deck
    ;Input operation to remove card from deck
    mov placeHolder, ecx
    removeCards deck, eax
    mov ecx, placeHolder
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
  lea edx, givenDeck
  delete: 
    cmp eax, ecx                         ;Check if the given address is the last element
    je end                               ;If element is the last one on the deck, jmp to end
    mov ebx, givenDeck[edx+(eax+1)*3]        ;Assign the value of the next element in the givenDeck to ebx
    mov givenDeck[edx+eax*3], ebx            ;Move the next element to the current position
    inc eax                              ;increment eax to the next position
    jmp delete                           ;Jump back to the beginning of the loop
  end:
    mov givenDeck[edx+eax*3], " "            ;Assign an empty value to the last element
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
    mov edx, " "                         ;Add a space between each element
    call WriteString                  
    inc ecx                              ;Point to the next element
    cmp ecx, size                        ;Check if ecx is more then the size of the array                          
    jle print                            ;Jmp to start of loop if ecx is less than or equal to the size of the array
    call crlf                            ;Move to a new line
ENDM

.data
; Create list containing cards
deck BYTE "1h",0, "2h",0, "3h",0,"4h",0,"5h",0,"6h",0
     BYTE "7h",0,"8h",0,"9h",0,"10h",0,"jh",0,"qh",0,"kh",0
     BYTE "ah",0,"1d",0,"2d",0,"3d",0,"4d",0,"5d",0,"6d",0
     BYTE "7d",0,"8d",0,"9d",0,"10d",0,"jd",0,"qd",0,"kd",0
     BYTE "ad",0,"1c",0,"2c",0,"3c",0,"4c",0,"5c",0,"6c",0,"7c",0
     BYTE "8c",0,"9c",0,"10c",0,"jc",0,"qc",0,"kc",0,"ac",0,"1s",0
     BYTE "2s",0,"3s",0,"4s",0,"5s",0,"6s",0,"7s",0,"8s",0,"9s",0
     BYTE "10s",0,"js",0,"qs",0,"ks",0,"as",0

playerDeck BYTE 52 DUP(?)
; Create list for computer deck
compDeck BYTE 52 DUP(?)
cardSearch BYTE "What number do you want to look for?", 0             ;Prompt for GOFish player
inputReminder BYTE "Input format: 1-9 for a number; jack = j, queen = q, king = k, ace = a", 0
placeHolder DWORD 0

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
    ;Random number from compDecks size if chose
    ;Computer asks for number/letter
    ;If player has matching cards, those cards will be surrenedered to computer's deck
      ;This transaction will be displayed
    ;Computers deck will be checked for macthes of 4
      ;If match is found, computer point increases

;Add a procedure for blackjack
  ;Extra
;Procedure for checking a value
;checkValue Proc
main ENDP
END main
