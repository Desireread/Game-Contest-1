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
    removeCards deck, placeHolder, deckCount                           ;Remove the card from deck

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
removeCards MACRO givenDeck, addr, size        ;Define the macro
  LOCAL delete, stop
  mov esi, OFFSET givenDeck              ;Load the first byte address of givenDeck
  mov eax, addr
  imul eax, 4
  add esi, eax                           ;Get the first byte address of teh starting index

  mov ecx, addr
  delete: 
    cmp ecx, size                         ;Check if the current element is the last one
    je stop                               ;If element is the last one on the deck, jmp to stop

    mov card, [esi+4]                    ;Load the next element into card
    mov [esi], card                      ;Load the next element into the current element
    add esi, 4                           ;Add to get to the next element
    inc ecx                              ;increase the index we are at
    jmp delete                           ;Jump back to the beginning of the loop

  stop:
    mov DWORD PTR [esi], 0           ;Assign an empty value to the last element

ENDM

display MACRO card
  

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
     BYTE "jok0","jok0"
deckCount DWORD 54
playerDeck BYTE 54*4 DUP(?)
; Create list for computer deck
compDeck BYTE 54*4 DUP(?)
;cardSearch BYTE "What number do you want to look for?", 0             ;Prompt for GOFish player
;inputReminder BYTE "Input format: 1-9 for a number; jack = j, queen = q, king = k, ace = a", 0

playerWins BYTE "You have won this round!",0
compWins BYTE "Computer has won this round!",0
bPrompt "Ready to play?",0

placeHolder DWORD 0
playerDeckCount DWORD 0
compDeckCount DWORD 0
count DWORD 0
card DWORD ?
playerCard DWORD ?
compCard DWORD ?

.code
main PROC
;Add a procedure for "I declare war"
  shuffle playerDeck, 26
  shuffle compDeck, 26




;Player types in whether to play
mov edx, bPrompt
call WriteString



main ENDP

;Zero flag is set if player wins, cleard if computer wins
compare PROC
  mov esi, OFFSET playerCard
  mov al, [esi]

  call IsDigit
  jz playerHasNumber

  jmp playHasCharacter

  playerHasNumber:                                  ;player has card 1-10
      mov ah, al                                    ;Save first character of playerCard in bl
      mov ebx, OFFSET compCard                      ;Load computer card into eax
      mov al, [ebx]                                 ;Load first character of computer card into al

      call IsDigit                                  ;test if computer card is also 1-10
      jnz computerWins                               ;Computer wins if it doesnt have a number card
      
      cmp ah, 1                                     ;Check if player has 10
      je p1                                             ;Jump to p1 if so, else jump to p0
      jmp p0
      
      p0:
         
          cmp al, 1                                 ;Check if computer has a 10
          je computerWins                                     ;If so computer wins
  
          inc esi                                   ;Go to the next characters
          inc ebx
          mov ah, [esi]
          mov al, [ebx]
          cmp ah, al                                ;Check which card wins
          ja playerWins                             ;Player wins if it has the higher card  
          jb computerWins                               ;Computer wins if it has the higher card
          jmp equal                                 ;Cards are equal, war is called


      p1:                                          ;Player has a 10
        cmp al,1                                   ;Check if computer has a 10
        jb playerWins                                ;Player wins if computer doesnt have a 10 else, they're equal
      
        jmp equals
          
        
      

  playerHasCharacter:                                
      mov ah, al                                    ;Save first character of playerCard in ah
      mov ebx, OFFSET compCard                      ;Load computer card into eax
      mov al, [ebx]                                 ;Load first character of computer card into al

      call IsDigit                                  ;test if computer card is also 1-10
      jz playerWins                                 ;Jump to playerWins if computer card is 1-10

      cmp ah, "j"
      je j

      cmp ah, "q"
      je q

      cmp ah, "k"
      je k
      
      j:
        cmp al, "j"
        inc esi
        inc ebx
        mov ah,[esi]
        mov al, [ebx]
        cmp ah, al  
        je war

        cmp ah, "o"
        je playerWins

        jmp comupterWins

      q:
        cmp al, "q"
        je war

        cmp al, "k"
        je computerWins

        inc ebx
        mov al,[ebx]
        cmp al, "o"
        je computerWins
        jump playerWins

      k:
        cmp al, "k"
        je war
    
        cmp al "j"
        jne playerWins

        inc ebx
        mov al,[ebx]
        cmp al, "o"
        je computerWins
        jump playerWins
        

  playerWins:
      

  computerWins:
    
  
  RET
ENDP compare

END main
