; Code for poker game

;Code to initialize file
.386
.model flat, stdcall
Include Irvine32.inc


;Macro to randomly assign nunCards amount of cards to a given deck
shuffle MACRO givenDeck, numCards
  LOCAL addCards
  mov ecx, 0                                      ;Start at 0 cards in the deck
  call Randomize                                  ;Randomly get key of the next address (Pg.164)
  addCards:
    
    mov eax, deckCount                              ;Load the amount of cards in deck into eax
    call RandomRange                                ;Get a random card based on the number of cards in deck

    mov placeHolder, eax                            ;Kepp the element index in placeHolder
    imul eax, 4                                     ;Multiple eax by 4 to get the location address of the card
    mov esi, OFFSET deck                           ;Load the first byte of deck into esi (pg. 118)
    add esi, eax                                   ;Add the index of the random card to eax to get the proper address
    mov ebx, [esi]                                 ;Load the card into ebx
  
    mov ecx, count                                   ;Save ecx in count
    removeCards deck, placeHolder                           ;Remove the card from deck

    mov count, ecx
    mov esi, OFFSET givenDeck                               ;Load the address of the first byte of givenDeck into esi
    mov eax, ecx                                            ;Load the index the random card needs to be inserted at into eax
    imul eax, 4                                             ;Multiply eax by 4 to get the starting byte address 
    add esi, eax                                            ;add the starting byte address to the address of te first byte in the given deck to get the address of the index where the random card will be placed
    mov [esi], ebx                                          ;Mov the random card into the proper address

    inc ecx                           ;The number of cards in givenDeck has increased                  
    dec deckCount                     ;The number of cards in deck has decreased
    cmp ecx, numCards                 ;Check if number of cards in givenDeck has reached the number of cards it needs to load
    jl addCards                                 ;Repeat loop if not
    
ENDM

;Macro to delete a card from a deck
removeCards MACRO givenDeck, addr        ;Define the macro
  LOCAL delete, stop
  mov esi, OFFSET givenDeck              ;Load the first byte address of givenDeck
  mov eax, addr
  imul eax, 4
  add esi, eax                           ;Get the first byte address of teh starting index

  mov eax, LENGTHOF givenDeck            ;Assign the length of the given deck to ecx
  shr eax, 2                             ;Get the number of elements in eax
  mov ecx, addr
  delete: 
    cmp ecx, eax                         ;Check if the given address is the last element
    je stop                               ;If element is the last one on the deck, jmp to stop

    mov card, [esi+4]                    ;Load the next element into card
    mov [esi], card                      ;Load the next element into the current element
    add esi, 4                           ;Add to get to the next element
    inc ecx                              ;increase the index we are at
    jmp delete                           ;Jump back to the beginning of the loop

  stop:
    mov DWORD PTR [esi], 0           ;Assign an empty value to the last element

ENDM



.data
; Create list containing cards
deck BYTE "01h0","02h0","03h0","04h0","05h0","06h0",
     BYTE "07h0","08h0","09h0","10h0","jh00","qh00","kh00"
     BYTE "0ah0","01d0","02d0","03d0","04d0","05d0","06d0"
     BYTE "07d0","08d0","09d0","10d0","jd00","qd00","kd00"
     BYTE "ad00","01c0","02c0","03c0","04c0","05c0","06c0","07c0"
     BYTE "08c0","09c0","10c0","jc00","qc00","kc00","ac00","01s0"
     BYTE "02s0","03s0","04s0","05s0","06s0","07s0","08s0","09s0"     
     BYTE "10s0","js00","qs00","ks00","as00"
     BYTE "jes0","jes0"
deckCount DWORD 54
playerDeck BYTE 54*4 DUP(?)
; Create list for computer deck
compDeck BYTE 54*4 DUP(?)
;cardSearch BYTE "What number do you want to look for?", 0             ;Prompt for GOFish player
;inputReminder BYTE "Input format: 1-9 for a number; jack = j, queen = q, king = k, ace = a", 0

placeHolder DWORD 0
playerDeckCount DWORD 0
compDeckCount DWORD 0
count DWORD 0
card DWORD ?

.code
main PROC
;Add a procedure for "I declare war"
shuffle playerDeck, 26
shuffle compDeck, 26


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
