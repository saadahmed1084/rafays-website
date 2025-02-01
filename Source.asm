include Irvine32.inc
include macros.inc
includelib Winmm.lib


; Declare the prototype for the PlaySound function
PlaySound PROTO,
    pszSound:PTR BYTE,
    hmod:DWORD,
    fdwSound:DWORD

AllDataSize = 5000
.data

SND_RESOURCE DWORD 00040005h
	SND_FILENAME    equ 00020000h
	SND_LOOP        equ 00000008h
	SND_ASYNC       equ 00000001h	
	Startsound   BYTE    "C:\Users\hp\Desktop\maintheme.wav", 0
    playsound3   BYTE    "C:\Users\hp\Desktop\gameover.wav", 0
	Round1   BYTE    "C:\Users\hp\Desktop\1.wav", 0
	Round2   BYTE    "C:\Users\hp\Desktop\2.wav", 0
	Round3   BYTE    "C:\Users\hp\Desktop\3.wav", 0


nameinput BYTE "Enter Your Name:",0
buffer db 255 dup(?)
info dd 0

GameName  BYTE "            |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||           ", 0ah
          BYTE "           ||                                                                                               ||          ", 0ah
          BYTE "          ||                                                                                                 ||         ", 0ah
          BYTE "         ||           !!!!!!!!!       -      -      &&&          &&&      ________      ++++++++              ||        ", 0ah
          BYTE "        ||                   !!      --      --    && &&        && &&     __      __   ++      ++              ||       ", 0ah
          BYTE "       ||                   !!       --      --    &&  &&      &&  &&     __      __   ++      ++               ||      ", 0ah
          BYTE "      ||                   !!        --      --    &&   &&    &&   &&     __      __   ++      ++                ||     ", 0ah
          BYTE "     ||                   !!         --      --    &&    &&  &&    &&     ________     ++      ++                 ||    ", 0ah
          BYTE "      ||                 !!          --      --    &&      &&      &&     __      __   ++++++++++                ||     ", 0ah
          BYTE "       ||               !!           --      --    &&              &&     __      __   ++      ++               ||      ", 0ah
          BYTE "        ||             !!            --      --    &&              &&     __      __   ++      ++              ||       ", 0ah
          BYTE "         ||            !!!!!!!!!      --------      &              &      ________     ++      ++             ||        ", 0ah
          BYTE "          ||                                                                                                 ||         ", 0ah
          BYTE "           ||                                                                                               ||          ", 0ah
   	      BYTE "            |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||           ", 0

menustr   BYTE "                       ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||                         ", 0ah
		  byte "                      ||                                                                      ||                        ",0ah
		  byte "                     ||        --        --                                                    ||                       ",0ah
		  byte "                    ||        -- --    -- --                                                    ||                      ",0ah
		  byte "                   ||         --  --  --  --                                                     ||                     ",0ah
		  byte "                  ||          --    --    --                                                      ||                    ",0ah
		  byte "                 ||           --          --                                                       ||                   ",0ah
		  byte "                ||            --          --                                                        ||                  ",0ah
		  byte "                 ||           --          --      ++++++++      &&&     &       _      _           ||                   ",0ah 
		  byte "                  ||          --          --     ++             && &&   &&     __      __         ||                    ",0ah
		  byte "                   ||         --          --     +++++++++      &&  &&  &&     __      __        ||                     ",0ah
		  byte "                    ||        --          --     ++             &&   && &&     __      __       ||                      ",0ah
		  byte "                     ||        -          -       ++++++++       &     &&&      ________       ||                       ",0ah
		  byte "                      ||                                                                      ||                        ",0ah
		  BYTE "                       ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||                         ", 0

StartMsg    db  "Press Space To Start Game",0
InstructMsg db  " Press I For Instruction",0
HistoryMsg  db  "  Press H For History",0


instScr   BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0ah
		  BYTE "                                                                                                                        ", 0ah
		  BYTE "     -      -                            !!!!!!!!!!!!!!!!!!              ________                                       ", 0ah
		  BYTE "    --      --                                   !!                     __     __                                       ", 0ah
		  BYTE "    --      --                                   !!                     __     __                                       ", 0ah
		  BYTE "    --      --                                   !!                     __     __                                       ", 0ah
		  BYTE "    ----------    -------    -        -          !!    !!!!!!!          ________   __          ________    __      __   ", 0ah
		  BYTE "    --      --   --     --  --        --         !!   !!     !!         __         __         __      __    __    __    ", 0ah
		  BYTE "    --      --   --     --  --   --   --         !!   !!     !!         __         __         __________     ______     ", 0ah
		  BYTE "    --      --   --     --  --   --   --         !!   !!     !!         __         __         __      __       __       ", 0ah
		  BYTE "     -      -     -------    ----  ----          !!    !!!!!!!           _          _______    _      _        __       ", 0ah
		  BYTE "                                                                                                                        ", 0ah
		  BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0

instMsg   BYTE "                                                                                                                        ",0ah
		  byte "                                       -   Level 1 : A Simple Level                                                     ",0ah 
		  byte "                                                 Three Different Color Balls                                            ",0ah
		  byte "                                                 Hit Same Color Balls to finish level                                   ",0ah
		  BYTE "                                                                                                                        ",0ah
		  byte "                                       !   Level 2 : Some Addons                                                        ",0ah 
		  byte "                                                 Four Different Color Balls                                             ",0ah
		  byte "                                                 Hit bonus for +100 scor                                                ",0ah
		  BYTE "                                                                                                                        ",0ah
		  byte "                                       _   Level 3 : Complex Level                                                      ",0ah 
		  byte "                                                 White color represent Bomb(remove 4 balls at random)                   ",0




; Level layout
walls BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                     1   1   1   1   1   1   1   1   1   1                  |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                         2                  |", 0
      BYTE "|                     X                                                      |", 0
      BYTE "|                    X X               ---                2                  |", 0
      BYTE "|                                    -     -                                 |", 0
      BYTE "|                     4              -     -              2                  |", 0
      BYTE "|                                    -     -                                 |", 0
      BYTE "|                     4                ---                2                  |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                     4                                   2                  |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                     3   3   3   3   3   3   3   3   3   3                  |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0

walls2 BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                     !   !   !   !   !   !   !                              |", 0
      BYTE "|                 !                              !                           |", 0
      BYTE "|             !                                     !                        |", 0
      BYTE "|                     X                                !                     |", 0
      BYTE "|             !      X X               ---                !                  |", 0
      BYTE "|                                    -     -                                 |", 0
      BYTE "|             !       !              -     -              !                  |", 0
      BYTE "|                                    -     -                                 |", 0
      BYTE "|             !       !                ---                !                  |", 0
      BYTE "|                        !                             !                     |", 0
      BYTE "|                           !                       !                        |", 0
      BYTE "|                              !                 !                           |", 0
      BYTE "|                                 !   !   !   !                              |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                                            |", 0
      BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0

walls3 BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0
      BYTE "|                                                                            |", 0
      BYTE "|            !        !        !        !        !        !                  |", 0
      BYTE "|                                                                            |", 0
      BYTE "|            !                                                               |", 0
      BYTE "|                     !     !     !     !     !     !     !                  |", 0
      BYTE "|                !                                            !              |", 0
      BYTE "|                                                                            |", 0
      BYTE "|                                                             !              |", 0
      BYTE "|                 !                    ---                                   |", 0
      BYTE "|            !                       -     -                                 |", 0
      BYTE "|                     !              -     -              !                  |", 0
      BYTE "|            !                       -     -                                 |", 0
      BYTE "|                     !                ---                                   |", 0
      BYTE "|            !                                      X         !              |", 0
      BYTE "|                           !                      X X                       |", 0
      BYTE "|            !                                                    !          |", 0
      BYTE "|                                 !     !     !     !                        |", 0
      BYTE "|            !                                                !              |", 0
      BYTE "|                                                                            |", 0
      BYTE "|            !        !        !        !        !        !                  |", 0
      BYTE "|                                                                            |", 0
      BYTE "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||", 0





ExitStr   BYTE "                |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||                 ",0ah
		  byte "               ||                                                                                     ||                ",0ah
		  byte "              ||                ------------                                                           ||               ",0ah
		  byte "             ||                --          --                                                           ||              ",0ah
		  byte "            ||                 --          --                                                            ||             ",0ah
		  byte "           ||                  --          --                                                             ||            ",0ah
		  byte "          ||                   --          --                                                              ||           ",0ah
		  byte "         ||                    --          --                                     &&&&&&&                   ||          ",0ah
		  byte "          ||                   --          --      _       _       ++++++++      &&     &&                 ||           ",0ah 
		  byte "           ||                  --          --      __     __      ++             &&&&&&&&                 ||            ",0ah
		  byte "            ||                 --          --       __   __       +++++++++      &&  &&                  ||             ",0ah
		  byte "             ||                --          --        __ __        ++             &&   &&                ||              ",0ah
		  byte "              ||                ------------          ___          ++++++++      &&    &&              ||               ",0ah
		  byte "               ||                                                                                     ||                ",0ah
		  byte "                |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||                 ",0


filename     BYTE "Scores.txt",0
fileHandle   HANDLE ?
fileHandle2   HANDLE ?
stringLength DWORD ?
bytesWritten DWORD ?
str1 BYTE "Cannot create file",0dh,0ah,0
str2 BYTE "Cannot Read file",0dh,0ah,0
AllData db AllDataSize dup(?)
gameover db 0
Heading db "Player",09H,"Score",09H,"Level",0
index2 dd ?



; Player sprite
player_right BYTE "   ", 0
             BYTE " O-", 0
             BYTE "   ", 0
player_left BYTE "   ", 0
            BYTE "-O ", 0
            BYTE "   ", 0
player_up BYTE " | ", 0
          BYTE " O ", 0
          BYTE "   ", 0
player_down BYTE "   ", 0
            BYTE " O ", 0
            BYTE " | ", 0
player_upright BYTE "  /", 0
              BYTE " O ", 0
              BYTE "   ", 0
player_upleft BYTE "\  ", 0
             BYTE " O ", 0
             BYTE "   ", 0
player_downright BYTE "   ", 0
               BYTE " O ", 0
               BYTE "  \", 0
player_downleft BYTE "   ", 0
              BYTE " O ", 0
              BYTE "/  ", 0

xBall db 41, 45, 49, 53, 57, 61, 65, 69, 73, 77, 77, 77, 77, 77, 77, 77, 73, 69, 65, 61, 57, 53, 49, 45, 41, 41, 41, 41
yBall db 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 11, 13, 15, 17, 19, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 19, 17, 15
color db 68, 34, 85, 85, 34, 34, 85, 85, 34, 34, 85, 85, 34, 68, 68, 85, 34, 34, 68, 85, 85, 68, 34, 34, 68, 34, 34, 68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
color_copy db 68, 34, 85, 85, 34, 34, 85, 85, 34, 34, 85, 85, 34, 68, 68, 85, 34, 34, 68, 85, 85, 68, 34, 34, 68, 34, 34, 68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
index db 0
colorCount db 28
found db 0


xBall2 db 33, 33, 33, 33, 37, 41, 45, 49, 53, 57, 61, 65, 68, 71, 74, 77, 77, 77, 74, 71, 68, 65, 61, 57, 53, 50, 47, 44, 41, 41
yBall2 db 17, 15, 13, 11, 10,  9,  9,  9,  9,  9,  9,  9, 10, 11, 12, 13, 15, 17, 18, 19, 20, 21, 21, 21, 21, 20, 19, 18, 17, 15
color2 db 68, 34, 34, 85,102, 85,102,102, 34, 68, 85,102, 85, 85,102, 68, 68, 34, 85,102,102, 85, 34, 34, 85,102, 34, 68, 85, 85 ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
color2_copy db 68, 34, 34, 85,102, 85,102,102, 34, 68, 85,102, 85, 85,102, 68, 68, 34, 85,102,102, 85, 34, 34, 85,102, 34, 68, 85, 85 ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
xBonus db 51,47,68,68,85,63,59,50
yBonus db 23,15,24,15,15,11,24,06
BonusIndex db 0
BonusTime dw 50 
firsttime db 0


xBall3 db 77, 68, 59, 50, 41, 32, 32, 36, 41, 47, 53, 59, 65, 71, 77, 81, 81, 77, 81, 85, 81, 77, 68, 59, 50, 41, 32, 32, 32, 32, 32, 32, 37, 41, 41, 47, 53, 59, 65, 71
yBall3 db 06, 06, 06, 06, 06,  6,  8, 10,  9,  9,  9,  9,  9,  9 , 9, 10, 12, 15, 18, 20, 22, 24, 24, 24, 24, 24, 24, 22, 20, 18, 16, 14, 13, 15, 17, 19, 21, 21, 21, 21
color3 db 68, 85, 34, 187, 85, 85, 102, 102, 34, 187, 187, 68, 85, 85, 102, 68, 187, 187, 34, 34, 68, 187, 85, 85, 34, 102, 187, 187, 68, 68, 85, 85, 34, 68, 102, 187, 187, 34, 68 ,102
       db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
color3_copy db 68, 85, 34, 187, 85, 85, 102, 102, 34, 187, 187, 68, 85, 85, 102, 68, 187, 187, 34, 34, 68, 187, 85, 85, 34, 102, 187, 187, 68, 68, 85, 85, 34, 68, 102, 187, 187, 34, 68 ,102
       db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
xBonus3 db 51,47,67,68,85,63
yBonus3 db 23,15,23,15,15,11

xPos db 58           ; Column (X)
yPos db 14           ; Row (Y)
xDir db 0
yDir db 0            ; Default character (initial direction)
inputChar db "d"
direction db "d"

; Colors for the emitter and player
color_red db 4       ; Red
color_green db 2     ; Green
color_yellow db 14   ; Yellow (for fire symbol)
current_color db 4   ; Default player color (red)
emitter_color1 db 2  ; Green
emitter_color2 db 4  ; Red
fire_color db 68     
Player_color db 4    

; Emitter properties
emitter_symbol db "#"
emitter_row db 0     ; Two rows above player (fixed row for emitter)
emitter_col db 1     ; Starting column of the emitter

; Fire symbol properties
fire_symbol db "*", 0
fire_row db 0
fire_col db 0        ; Initial fire column will be set in the update logic

; Interface variables
score dd 0          ; Player's score
lives db 3           ; Player's lives
level db 1

; Counter variables for loops
counter1 db 0
counter2 db 0

time dd 255

.code

main PROC
     mov eax, SND_FILENAME  ; pszSound is a file name
    or eax, SND_ASYNC      ; Play in the background

    invoke PlaySound, addr StartSound, 0, eax
    call Page1
    mov eax,white+(black * 16)
	call SetTextColor
	call clrscr

	call menuscr	
	mov eax,white+(black * 16)
	call SetTextColor
	call clrscr
	
	

    call Level1
	cmp gameover , 1
	je exitGame

	call Level2
	cmp gameover , 1
	je exitGame
	
	call Level3
	cmp gameover , 1
	je exitGame



	exitGame:
    call MakeString
	call lastPage
	call ReadFile1
	call FindIndex
	call FinalString
	call WriteFile1

    exit
main ENDP

Level1 PROC

    mov eax, SND_FILENAME  ; pszSound is a file name
    or eax, SND_ASYNC      ; Play in the background

    invoke PlaySound, addr round1, 0, eax
    newlife:
    mov index,0
    mov colorCount,28
    mov time,200
    mov fire_color , 68     
    mov Player_color , 4
    call clrscr
    mov eax,black+(black * 16)
	call SetTextColor
    call InitialiseScreen
    
    mov time,0

    Gameloop:

        mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 19
        mov dh, 2
        call Gotoxy
        mWrite <"Score: ">

        mov eax, Blue + (Black * 16)
        call SetTextColor
        mov eax , score
        call WriteDec

        mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 90
        mov dh, 2
        call Gotoxy
        mWrite <"Lives: ">

        mov eax, Red + (Black * 16)
        call SetTextColor
        mov al, lives
        call WriteDec

        mov dx, 0
        call GoToXY

    checkInput:
        mov eax, 5
        call Delay

        mov eax, 0
        call ReadKey
        mov inputChar, al

        cmp inputChar, VK_SPACE
        je shoot
        cmp inputChar, "p"
        je paused
        cmp inputChar, "n"
        je next
        cmp inputChar, "w"
        je move
        cmp inputChar, "a"
        je move
        cmp inputChar, "x"
        je move
        cmp inputChar, "d"
        je move
        cmp inputChar, "q"
        je move
        cmp inputChar, "e"
        je move
        cmp inputChar, "z"
        je move
        cmp inputChar, "c"
        je move
        jmp return

        ; If character is invalid, check for a new keypress
        ;jmp checkInput

    move:
        mov al, inputChar
        mov direction, al
        jmp chosen

    paused:
        call ReadChar
		cmp al,"o"
        je Gameloop
        jmp paused

    shoot:
        call FireBall
        call changeFireBallColor
        call PrintPlayer

    chosen:
        call PrintPlayer

    return:


    cmp time , 200
    jne noball

    call ClearBallPositions
    call DrawBall

    cmp index,29
    jge over

    ;inc index
    mov time,0

    noball:

    inc time
    call CheckNonZero
    cmp eax, 1
    je HasNonZero
    jmp next

    HasNonZero:
    
    jmp Gameloop

    over:
    cmp lives,1
    jle do
    dec lives
    call copy
    jmp newlife

    do:
    mov gameover , 1
    next:

    ret
Level1 ENDP

Level2 PROC
    
    mov eax, SND_FILENAME  ; pszSound is a file name
    or eax, SND_ASYNC      ; Play in the background
    invoke PlaySound, addr round2, 0, eax
    mov level,2
    mov lives,3

    newlife:
    mov fire_color , 68     
    mov Player_color , 4
    
    mov index, 0
    mov colorCount, 30
    
    mov inputChar,"d"
    call clrscr
    mov eax,black+(black * 16)
	call SetTextColor
    call InitialiseScreen
    mov time,150

    Gameloop:

        mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 19
        mov dh, 2
        call Gotoxy
        mWrite <"Score: ">

        mov eax, Brown + (Black * 16)
        call SetTextColor
        mov eax , score
        call WriteDec

        mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 90
        mov dh, 2
        call Gotoxy
        mWrite <"Lives: ">

        mov eax, Red + (Black * 16)
        call SetTextColor
        mov al, lives
        call WriteDec

        mov dx, 0
        call GoToXY

    checkInput:
        mov eax, 5
        call Delay

        mov eax, 0
        call ReadKey
        mov inputChar, al

        cmp inputChar, VK_SPACE
        je shoot
        cmp inputChar, "p"
        je paused
        cmp inputChar, "n"
        je next
        cmp inputChar, "w"
        je move
        cmp inputChar, "a"
        je move
        cmp inputChar, "x"
        je move
        cmp inputChar, "d"
        je move
        cmp inputChar, "q"
        je move
        cmp inputChar, "e"
        je move
        cmp inputChar, "z"
        je move
        cmp inputChar, "c"
        je move
        jmp return

        ; If character is invalid, check for a new keypress
        ;jmp checkInput

    move:
        mov al, inputChar
        mov direction, al
        jmp chosen

    paused:
        call ReadChar
		cmp al,"o"
        je Gameloop
        jmp paused

    shoot:
        call FireBall
        call changeFireBallColor2
        call PrintPlayer

    chosen:
        call PrintPlayer

    return:


    cmp time , 150
    jne noball

    call ClearBallPositions2
    call DrawBall2

    cmp index,31
    jge over

    mov time,0

    noball:

    inc time
    cmp Bonustime,300
    jne noBonus
    inc firsttime
    call DrawBonus
    mov Bonustime,0

    noBonus:
    inc Bonustime

    call CheckNonZero
    cmp eax, 1
    je HasNonZero
    jmp next

    HasNonZero:

    jmp Gameloop

    over:
    cmp lives,1
    jle do
    dec lives
    call copy
    jmp newlife

    do:
    mov gameover , 1
    next:

    ret
Level2 ENDP


Level3 PROC
    
    mov level,3
    mov lives,3
    mov eax, SND_FILENAME  ; pszSound is a file name
    or eax, SND_ASYNC      ; Play in the background
    invoke PlaySound, addr round3, 0, eax
    
    newlife:
    mov index, 0
    mov colorCount, 40
    mov fire_color , 68     
    mov Player_color , 4
    mov  BonusIndex , 0
    mov  BonusTime ,  0 
    mov  firsttime ,  0
    mov inputChar,"d"
    call clrscr
    mov eax,black+(black * 16)
	call SetTextColor
    call InitialiseScreen
    mov time,150

    Gameloop:

        mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 19
        mov dh, 2
        call Gotoxy
        mWrite <"Score: ">

        mov eax, Brown + (Black * 16)
        call SetTextColor
        mov eax , score
        call WriteDec

        mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 90
        mov dh, 2
        call Gotoxy
        mWrite <"Lives: ">

        mov eax, Red + (Black * 16)
        call SetTextColor
        mov al, lives
        call WriteDec

        mov dx, 0
        call GoToXY

    checkInput:
        mov eax, 5
        call Delay

        mov eax, 0
        call ReadKey
        mov inputChar, al

        cmp inputChar, VK_SPACE
        je shoot
        cmp inputChar, "p"
        je paused
        cmp inputChar, "n"
        je next
        cmp inputChar, "w"
        je move
        cmp inputChar, "a"
        je move
        cmp inputChar, "x"
        je move
        cmp inputChar, "d"
        je move
        cmp inputChar, "q"
        je move
        cmp inputChar, "e"
        je move
        cmp inputChar, "z"
        je move
        cmp inputChar, "c"
        je move
        jmp return

        ; If character is invalid, check for a new keypress
        ;jmp checkInput

    move:
        mov al, inputChar
        mov direction, al
        jmp chosen

    paused:
        call ReadChar
		cmp al,"o"
        je Gameloop
        jmp paused

    shoot:
        call FireBall
        call changeFireBallColor3
        call PrintPlayer

    chosen:
        call PrintPlayer

    return:


    cmp time , 150
    jne noball

    call ClearBallPositions3
    call DrawBall3

    cmp index,41
    jge over

    mov time,0

    noball:

    inc time
    cmp Bonustime,300
    jne noBonus
    inc firsttime
    call DrawBonus3
    mov Bonustime,0

    noBonus:
    inc Bonustime

    call CheckNonZero
    cmp eax, 1
    je HasNonZero
    jmp next

    HasNonZero:

    jmp Gameloop

    over:
    cmp lives,1
    jle do
    dec lives
    call copy
    jmp newlife

    do:
    mov gameover , 1
    next:

    ret
Level3 ENDP


copy PROC
mov ecx, LENGTHOF color_copy
mov esi,0
l1:
mov al,[color_copy+esi]
mov [color+esi],al
inc esi
loop l1
    ret
copy ENDP

FireBall PROC
    ; Fire a projectile from the player's current face direction
    mov dl, xPos        ; Fire column starts at the player's X position
    mov dh, yPos        ; Fire row starts at the player's Y position
    mov fire_col, dl    ; Save the fire column position
    mov fire_row, dh    ; Save the fire row position
    mov al, direction

    cmp al, "w"
    je fire_up
    cmp al, "x"
    je fire_down
    cmp al, "a"
    je fire_left
    cmp al, "d"
    je fire_right
    cmp al, "q"
    je fire_upleft
    cmp al, "e"
    je fire_upright
    cmp al, "z"
    je fire_downleft
    cmp al, "c"
    je fire_downright
    jmp end_fire

fire_up:
    mov fire_row, 13    ; Move fire position upwards
    mov fire_col, 59    ; Center fire position
    mov xDir, 0
    mov yDir, -1
    jmp fire_loop

fire_down:
    mov fire_row, 17    ; Move fire position downwards
    mov fire_col, 59    ; Center fire position
    mov xDir, 0
    mov yDir, 1
    jmp fire_loop

fire_left:
    mov fire_col, 56   ; Move fire position leftwards
    mov fire_row, 15    ; Center fire position
    mov xDir, -1
    mov yDir, 0
    jmp fire_loop

fire_right:
    mov fire_col, 62    ; Move fire position rightwards
    mov fire_row, 15    ; Center fire position
    mov xDir, 1
    mov yDir, 0
    jmp fire_loop

fire_upleft:
    mov fire_row, 14    ; Move fire position upwards
    mov fire_col, 58  ; Move fire position leftwards
    mov xDir, -1
    mov yDir, -1
    jmp fire_loop

fire_upright:
    mov fire_row, 14    ; Move fire position upwards
    mov fire_col, 60    ; Move fire position rightwards
    mov xDir, 1
    mov yDir, -1
    jmp fire_loop

fire_downleft:
    mov fire_row, 16    ; Move fire position downwards
    mov fire_col, 58    ; Move fire position leftwards
    mov xDir, -1
    mov yDir, 1
    jmp fire_loop

fire_downright:
    mov fire_row, 16    ; Move fire position downwards
    mov fire_col, 60    ; Move fire position rightwards
    mov xDir, 1
    mov yDir, 1
    jmp fire_loop

fire_loop:
    ; Initialize fire position
    mov dl, fire_col
    mov dh, fire_row
    call GoToXY

L1:
    ; Ensure fire stays within the bounds of the emitter wall
    cmp dl, 20          ; Left wall boundary
    jle end_fire
    cmp dl, 95          ; Right wall boundary
    jge end_fire
    cmp dh, 5           ; Upper wall boundary
    jle end_fire
    cmp dh, 25          ; Lower wall boundary
    jge end_fire

    ; Print the fire symbol at the current position
    movzx eax, fire_color
    call SetTextColor
    add dl, xDir
    add dh, yDir
    cmp level,2
    je lvl2
    cmp level,3 
    je lvl3
    call checkCollision
    jmp donne

    lvl2:
    call checkCollision2
    jmp donne

    lvl3:
    call checkCollision3
    jmp donne

    donne:
    call GoToXY
    mWrite "*"

    mov eax, 50
    call Delay

    ; Erase the fire before redrawing it
    mov eax,(black+(black*16))
    call SetTextColor
    call GoToXY
    mWrite " "
    jmp L1

end_fire:
    mov dx, 0
    call GoToXY
    ret
FireBall ENDP


DrawWall PROC
    call clrscr

    mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 55
        mov dh, 2
        call Gotoxy
        mWrite "LEVEL "

        mov al, level
        call WriteDec

    mov eax, Gray + (Black * 16)
    call SetTextColor
    mov dl, 19
    mov dh, 4
    call Gotoxy

    mov esi, offset walls
    mov counter1, 23
    mov counter2, 79
    movzx ecx, counter1

printcolumn:
    mov counter1, cl
    movzx ecx, counter2

printrow:
    mov eax, [esi]
    cmp al , "|"
    jne next
    mov eax, blue + (blue * 16)
    call SetTextColor
    next:
    cmp al , "X"
    jne next2 
    mov eax, white + (blue * 16)
    call SetTextColor
    next2:
    cmp al , "-"
    jne next3
    mov eax, black + (white * 16)
    call SetTextColor
    next3:
    mov eax, [esi]
    call WriteChar
    mov eax, Gray + (Black * 16)
    call SetTextColor
    inc esi
    loop printrow

    movzx ecx, counter1
    mov dl, 19
    inc dh
    call Gotoxy
    loop printcolumn

    ret
DrawWall ENDP

PrintPlayer PROC
    mov eax, 0
    mov al , Player_color
    call SetTextColor

    mov al, direction
    cmp al, "w"
    je print_up
    cmp al, "x"
    je print_down
    cmp al, "a"
    je print_left
    cmp al, "d"
    je print_right
    cmp al, "q"
    je print_upleft
    cmp al, "e"
    je print_upright
    cmp al, "z"
    je print_downleft
    cmp al, "c"
    je print_downright
    ret

print_up:
    mov esi, offset player_up
    jmp print

print_down:
    mov esi, offset player_down
    jmp print

print_left:
    mov esi, offset player_left
    jmp print

print_right:
    mov esi, offset player_right
    jmp print

print_upleft:
    mov esi, offset player_upleft
    jmp print

print_upright:
    mov esi, offset player_upright
    jmp print

print_downleft:
    mov esi, offset player_downleft
    jmp print

print_downright:
    mov esi, offset player_downright
    jmp print

print:
    mov dl, xPos
    mov dh, yPos
    call GoToXY

    mov counter1, 3
    mov counter2, 4
    movzx ecx, counter1

printcolumn:
    mov counter1, cl
    movzx ecx, counter2

printrow:
    mov eax, [esi]
    call WriteChar
    inc esi
    loop printrow

    movzx ecx, counter1
    mov dl, xPos
    inc dh
    call Gotoxy
    loop printcolumn

    ret
PrintPlayer ENDP

MovePlayer PROC
    mov dx, 0
    call GoToXY

checkInput:
    mov eax, 5
    call Delay

    mov eax, 0
    call ReadKey
    mov inputChar, al

    cmp inputChar, VK_SPACE
    je shoot
    cmp inputChar, VK_ESCAPE
    je paused
    cmp inputChar, "w"
    je move
    cmp inputChar, "a"
    je move
    cmp inputChar, "x"
    je move
    cmp inputChar, "d"
    je move
    cmp inputChar, "q"
    je move
    cmp inputChar, "e"
    je move
    cmp inputChar, "z"
    je move
    cmp inputChar, "c"
    je move
    jmp return

    ; If character is invalid, check for a new keypress
    ;jmp checkInput

move:
    mov al, inputChar
    mov direction, al
    jmp chosen

paused:
    ; Call your pause menu here or handle pause logic
    ret

shoot:
    call FireBall
    call changeFireBallColor
    call PrintPlayer

chosen:
    call PrintPlayer
    ;call MovePlayer

return:
    ret
MovePlayer ENDP

changeFireBallColor PROC

    generate_random:
    mov ecx, 3        ; Set ECX to 3 (upper limit)
    rdtsc            ; Read the time-stamp counter into EDX:EAX
    xor edx, edx     ; Clear EDX
    div ecx          ; Divide EDX:EAX by ECX, quotient in EAX, remainder in EDX
    mov eax, edx     ; Move remainder (random number) to EAX
    
    cmp eax, 0
    jne next
    mov fire_color,68
    mov Player_color,4
    jmp return
    next:
    cmp eax, 1
    jne next1
    mov fire_color,34
    mov Player_color,2
    jmp return
    next1:
    mov fire_color,85
    mov Player_color,5
    jmp return

    return:


    ret
changeFireBallColor ENDP

InitialiseScreen PROC
    ; Draw the level layout at the start
    cmp level , 2
    je level_2
    cmp level , 3
    je level_3
    call DrawWall
    jmp done

    level_2:
    call DrawWall2
    jmp done

    level_3:
    call DrawWall3
    jmp done


    done:
    call PrintPlayer
    ret
InitialiseScreen ENDP


DrawBall PROC


    mov esi, 0                  ; Index for the xBall and yBall arrays
    mov ecx, LENGTHOF xBall     ; Number of elements in xBall and yBall arrays

ClearLoop:
    cmp esi, ecx                ; Check if we reached the end of the arrays
    jge Done                    ; If yes, exit the loop

    ; Load x and y coordinates
    mov dl, [xBall + esi]       ; Get x-coordinate
    mov dh, [yBall + esi]       ; Get y-coordinate
    call Gotoxy                 ; Move cursor to (x, y)

    ; Set color to Black + (Black * 16)
    mov eax, 0                  ; 0 = Black + (Black * 16)
    call SetTextColor           ; Set the text color to black

    ; Print a space to "clear" the position
    mov al, ' '                 ; Character to print (space)
    call WriteChar              ; Write the character at the position

    inc esi                     ; Move to the next index
    jmp ClearLoop               ; Repeat the loop

Done:
    
    mov esi , 0

    mov ebx,0
    mov bl,index
    l1:
    mov dl, [xBall + ebx]   
    mov dh, [yBall + ebx] 
    call CheckCharacter
    
    call Gotoxy 
    mov edx,eax
    mov eax,0
    mov al,[color + esi]
    cmp al,0
    je l2
    mov [walls+edx],"@"
	call SetTextColor
    mov al, "@"
    call WriteChar
    l2:
    inc esi
    dec ebx
    cmp ebx,0
    jge l1

    inc index


    ret
DrawBall ENDP


AddElementShift PROC
    ; Input: AL = value to add, BL = index where to insert

    mov ecx, 0                ; Load current count into ECX for the loop
    mov cl,colorCount
    ;dec ecx                    ; Start from the last valid element
    mov esi , ecx
    dec esi
    sub ecx,ebx

    shift_loop:
    mov dl, [color + esi]      ; Load element at index ECX
    mov [color + esi + 1], dl  ; Move it forward
    dec esi
    loop shift_loop           ; Decrement ECX and continue

    ; Insert the new element
    mov eax,0
    mov al , fire_color
    mov [color + ebx], al     ; Place the new value at the specified index

    ; Update the count
    inc colorCount     ; Increment the count of elements
    
    jmp done


    done:
    ret
AddElementShift ENDP

CheckCharacter PROC
    push ebx
    mov eax, 0           ; Clear EAX
    mov al, dh           ; Move Y-coordinate (DH) into AL
    sub al, 4            ; Adjust Y-coordinate (assuming walls starts at row 4)
    imul eax, eax, 79    ; Multiply adjusted Y by 79 (row width) and store result in EAX
    mov ebx, 0           ; Clear EBX
    mov bl, dl           ; Move X-coordinate (DL) into BL
    sub bl, 19           ; Adjust X-coordinate (assuming walls starts at column 19)
    add eax, ebx         ; Add X-offset to the row offset
    pop ebx
    ret
CheckCharacter ENDP





checkCollision PROC
    
    call CheckCharacter  ; Get the character at (112, 15)
    cmp dl,59
    jne normal
    sub eax , 2
    normal:
    cmp  [walls+eax],"@"
    jne clear2


    ; Check specific locations one by one
    cmp dl, 53       ; Check x-coordinate for (53, 9)
    jne check_59_9
    cmp dh, 9
    je loc_53_9      ; Jump if (53, 9) matches
    jmp check_59_9   ; Continue checking if not

check_59_9:
    cmp dl, 59       ; Check x-coordinate for (59, 9)
    jne check_65_9
    cmp dh, 9
    je loc_59_9      ; Jump if (59, 9) matches
    jmp check_65_9

check_65_9:
    cmp dl, 65       ; Check x-coordinate for (65, 9)
    jne check_53_21
    cmp dh, 9
    je loc_65_9      ; Jump if (65, 9) matches
    jmp check_53_21

check_53_21:
    cmp dl, 53       ; Check x-coordinate for (53, 21)
    jne check_59_21
    cmp dh, 21
    je loc_53_21     ; Jump if (53, 21) matches
    jmp check_59_21

check_59_21:
    cmp dl, 59       ; Check x-coordinate for (59, 21)
    jne check_65_21
    cmp dh, 21
    je loc_59_21     ; Jump if (59, 21) matches
    jmp check_65_21

check_65_21:
    cmp dl, 65       ; Check x-coordinate for (65, 21)
    jne check_77_15
    cmp dh, 21
    je loc_65_21     ; Jump if (65, 21) matches
    jmp check_77_15

check_77_15:
    cmp dl, 77       ; Check x-coordinate for (77, 15)
    jne check_41_15
    cmp dh, 15
    je loc_77_15     ; Jump if (77, 15) matches
    jmp check_41_15

check_41_15:
    cmp dl, 41       ; Check x-coordinate for (41, 15)
    jne clear2
    cmp dh, 15
    je loc_41_15     ; Jump if (41, 15) matches
    jmp clear2

; Label for specific locations
loc_53_9:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l1:
    cmp [xBall + eax], 53
    jne l2
    cmp [yBall + eax], 9
    jne l2
    call AddElementShift
    jmp clear

    l2:
    dec eax
    inc ebx
    jmp l1


loc_59_9:
   mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l3:
    cmp [xBall + eax], 57
    jne l4
    cmp [yBall + eax], 9
    jne l4
    call AddElementShift
    jmp clear

    l4:
    dec eax
    inc ebx
    jmp l3

    

loc_65_9:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l5:
    cmp [xBall + eax], 65
    jne l6
    cmp [yBall + eax], 9
    jne l6
    call AddElementShift
    jmp clear

    l6:
    dec eax
    inc ebx
    jmp l5

   

loc_53_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l7:
    cmp [xBall + eax], 53
    jne l8
    cmp [yBall + eax], 21
    jne l8
    call AddElementShift
    jmp clear

    l8:
    dec eax
    inc ebx
    jmp l7

   

loc_59_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l9:
    cmp [xBall + eax], 57
    jne l10
    cmp [yBall + eax], 21
    jne l10
    call AddElementShift
    jmp clear

    l10:
    dec eax
    inc ebx
    jmp l9

loc_65_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l11:
    cmp [xBall + eax], 65
    jne l12
    cmp [yBall + eax], 21
    jne l12
    call AddElementShift
    jmp clear

    l12:
    dec eax
    inc ebx
    jmp l11

loc_77_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l13:
    cmp [xBall + eax], 77
    jne l14
    cmp [yBall + eax], 15
    jne l14
    call AddElementShift
    jmp clear

    l14:
    dec eax
    inc ebx
    jmp l13


loc_41_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l15:
    cmp [xBall + eax], 41
    jne l16
    cmp [yBall + eax], 15
    jne l16
    call AddElementShift
    jmp clear

    l16:
    dec eax
    inc ebx
    jmp l15

    mov dl, 0
    mov dh ,0
    jmp clear

clear:
mov dx,0
call TripleCheck
mov dx,0
clear2:
    
    ret
checkCollision ENDP

TripleCheck PROC
    mov esi, 0               ; Index pointer for the array
    mov edi, 0               ; Write pointer for the modified array
    mov ecx, LENGTHOF color  ; Total number of elements in the array
    mov found, 0             ; Flag to indicate if a triplet has been found (0 = no, 1 = yes)

CheckNextTriple:
    ; Check if we've reached the end of the array
    cmp esi, ecx
    jge Done                 ; If at the end, exit

    ; If a triplet is found
    cmp found, 1             ; Have we already found a triplet?
    je NotTriple             ; If yes, skip processing further triplets

    ; Check for three consecutive elements
    mov al, [color + esi]    ; Load current element
    cmp al, [color + esi + 1]
    jne NotTriple            ; If not equal, move to next element
    cmp al, [color + esi + 2]
    jne NotTriple            ; If not equal, move to next element
    cmp al, 0
    je Done                  ; If zero, exit

    

    ; Process the first triplet found
    mov found, 1             ; Set the flag to indicate a triplet has been found
    add esi, 3               ; Move the index pointer forward by 3 (skip triplet)
    sub index, 3             ; Decrease the index count
    sub colorCount, 3        ; Decrease the color count
    add score, 30            ; Increment the score
    jmp CheckNextTriple      ; Continue checking the rest of the array

NotTriple:
    ; If not a triplet or triplet already processed, copy the element
    mov al, [color + esi]    ; Load current element
    mov [color + edi], al    ; Store it at the write pointer
    inc esi                  ; Move to the next element
    inc edi                  ; Move the write pointer forward
    jmp CheckNextTriple

Done:
    ; Fill the rest of the array with 0 to clear unused space
    mov eax, 0
FillRest:
    cmp edi, ecx
    jge Finish
    mov [color + edi], al    ; Clear the unused elements
    inc edi
    jmp FillRest

Finish:
    call ClearBallPositions  ; Call external functions
    call DrawBall
    ret
TripleCheck ENDP


ClearBallPositions PROC
    mov esi, 0                  ; Index for the xBall and yBall arrays
    mov ecx, LENGTHOF xBall     ; Number of elements in xBall and yBall arrays

ClearLoop:
    cmp esi, ecx                ; Check if we reached the end of the arrays
    jge Done                    ; If yes, exit the loop

    ; Load x and y coordinates
    mov dl, [xBall + esi]       ; Get x-coordinate
    mov dh, [yBall + esi]       ; Get y-coordinate
    call CheckCharacter
    mov [walls+eax]," "
    call Gotoxy                 ; Move cursor to (x, y)

    ; Set color to Black + (Black * 16)
    mov eax, 0                  ; 0 = Black + (Black * 16)
    call SetTextColor           ; Set the text color to black

    ; Print a space to "clear" the position
    mov al, ' '                 ; Character to print (space)
    call WriteChar              ; Write the character at the position

    inc esi                     ; Move to the next index
    jmp ClearLoop               ; Repeat the loop

Done:
    ret
ClearBallPositions ENDP

CheckNonZero PROC
    ; Input: None
    ; Output: ZF (Zero Flag) set if no non-zero elements are found
    ;         ZF cleared if at least one non-zero element exists

    push esi               ; Save the index register

    cmp level,1
    je lvl1
    cmp level ,3
    je lvl3
    mov esi, OFFSET color2 
    mov ecx, LENGTHOF color2 
    jmp CheckLoop

    lvl1:
    mov esi, OFFSET color 
    mov ecx, LENGTHOF color 
    jmp CheckLoop

    lvl3:
    mov esi, OFFSET color3
    mov ecx, LENGTHOF color3 
    jmp CheckLoop



CheckLoop:
    cmp byte ptr [esi], 0  ; Compare the current element with 0
    jne FoundNonZero       ; If not zero, exit loop (non-zero found)
    inc esi                ; Move to the next element
    loop CheckLoop         ; Decrement ECX and continue looping if ECX > 0

    xor eax, eax           ; No non-zero element found, clear EAX
    jmp Done

FoundNonZero:
    mov eax, 1             ; Found a non-zero element, set EAX to 1

Done:
    pop esi                ; Restore the index register
    ret
CheckNonZero ENDP


;LEVEL 2-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DrawWall2 PROC
    call clrscr

    mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 55
        mov dh, 2
        call Gotoxy
        mWrite "LEVEL "

        mov al, level
        call WriteDec

    mov eax, Gray + (Black * 16)
    call SetTextColor
    mov dl, 19
    mov dh, 4
    call Gotoxy

    mov esi, offset walls2
    mov counter1, 23
    mov counter2, 79
    movzx ecx, counter1

printcolumn:
    mov counter1, cl
    movzx ecx, counter2

printrow:
    mov eax, [esi]
    cmp al , "|"
    jne next
    mov eax, blue + (blue * 16)
    call SetTextColor
    next:
    cmp al , "X"
    jne next2
    mov eax, white + (blue * 16)
    call SetTextColor
    next2:
    cmp al , "-"
    jne next3
    mov eax, black + (white * 16)
    call SetTextColor
    next3:
    mov eax, [esi]
    call WriteChar
    mov eax, Gray + (Black * 16)
    call SetTextColor
    inc esi
    loop printrow

    movzx ecx, counter1
    mov dl, 19
    inc dh
    call Gotoxy
    loop printcolumn

    ret
DrawWall2 ENDP



checkCollision2 PROC

    mov eax,0
    mov al,BonusIndex
    cmp dl,[xBonus+eax]
    jne noBonus
    cmp dh,[yBonus+eax]
    jne noBonus
    call Erase
    add score,100
    jmp clear1

    noBonus:

    
    call CheckCharacter  ; Get the character at (112, 15)
    cmp dl,59
    jne normal
    sub eax , 2
    normal:
    cmp [walls2+eax],"@"
    jne clear2


    ; Check specific locations one by one
    cmp dl, 53       ; Check x-coordinate for (53, 9)
    jne check_59_9
    cmp dh, 9
    je loc_53_9      ; Jump if (53, 9) matches
    jmp check_59_9   ; Continue checking if not

check_59_9:
    cmp dl, 59       ; Check x-coordinate for (59, 9)
    jne check_65_9
    cmp dh, 9
    je loc_59_9      ; Jump if (59, 9) matches
    jmp check_65_9

check_65_9:
    cmp dl, 65       ; Check x-coordinate for (65, 9)
    jne check_53_21
    cmp dh, 9
    je loc_65_9      ; Jump if (65, 9) matches
    jmp check_53_21

check_53_21:
    cmp dl, 53       ; Check x-coordinate for (53, 21)
    jne check_59_21
    cmp dh, 21
    je loc_53_21     ; Jump if (53, 21) matches
    jmp check_59_21

check_59_21:
    cmp dl, 59       ; Check x-coordinate for (59, 21)
    jne check_65_21
    cmp dh, 21
    je loc_59_21     ; Jump if (59, 21) matches
    jmp check_65_21

check_65_21:
    cmp dl, 65       ; Check x-coordinate for (65, 21)
    jne check_77_15
    cmp dh, 21
    je loc_65_21     ; Jump if (65, 21) matches
    jmp check_77_15

check_77_15:
    cmp dl, 77       ; Check x-coordinate for (77, 15)
    jne check_41_15
    cmp dh, 15
    je loc_77_15     ; Jump if (77, 15) matches
    jmp check_41_15

check_41_15:
    cmp dl, 41       ; Check x-coordinate for (41, 15)
    jne check_33_15
    cmp dh, 15
    je loc_33_15     ; Jump if (41, 15) matches
    jmp check_33_15

check_33_15:
    cmp dl, 33       ; Check x-coordinate for (41, 15)
    jne clear2
    cmp dh, 15
    je loc_33_15     ; Jump if (41, 15) matches
    jmp clear2

; Label for specific locations
loc_53_9:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l1:
    cmp [xBall2 + eax], 53
    jne l2
    cmp [yBall2 + eax], 9
    jne l2
    call AddElementShift2
    jmp clear

    l2:
    dec eax
    inc ebx
    jmp l1


loc_59_9:
   mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l3:
    cmp [xBall2 + eax], 57
    jne l4
    cmp [yBall2 + eax], 9
    jne l4
    call AddElementShift2
    jmp clear

    l4:
    dec eax
    inc ebx
    jmp l3

    

loc_65_9:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l5:
    cmp [xBall2 + eax], 65
    jne l6
    cmp [yBall2 + eax], 9
    jne l6
    call AddElementShift2
    jmp clear

    l6:
    dec eax
    inc ebx
    jmp l5

   

loc_53_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l7:
    cmp [xBall2 + eax], 53
    jne l8
    cmp [yBall2 + eax], 21
    jne l8
    call AddElementShift2
    jmp clear

    l8:
    dec eax
    inc ebx
    jmp l7

   

loc_59_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l9:
    cmp [xBall2 + eax], 57
    jne l10
    cmp [yBall2 + eax], 21
    jne l10
    call AddElementShift2
    jmp clear

    l10:
    dec eax
    inc ebx
    jmp l9

loc_65_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l11:
    cmp [xBall2 + eax], 65
    jne l12
    cmp [yBall2 + eax], 21
    jne l12
    call AddElementShift2
    jmp clear

    l12:
    dec eax
    inc ebx
    jmp l11

loc_77_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l13:
    cmp [xBall2 + eax], 77
    jne l14
    cmp [yBall2 + eax], 15
    jne l14
    call AddElementShift2
    jmp clear

    l14:
    dec eax
    inc ebx
    jmp l13


loc_41_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l15:
    cmp [xBall2 + eax], 41
    jne l16
    cmp [yBall2 + eax], 15
    jne l16
    call AddElementShift2
    jmp clear

    l16:
    dec eax
    inc ebx
    jmp l15

loc_33_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l17:
    cmp [xBall2 + eax], 33
    jne l18
    cmp [yBall2 + eax], 15
    jne l18
    call AddElementShift2
    jmp clear

    l18:
    dec eax
    inc ebx
    jmp l17   

clear:
mov dx,0
call TripleCheck2
clear1:
mov dx,0
clear2:
    
    ret
checkCollision2 ENDP

DrawBall2 PROC


    mov esi, 0                  ; Index for the xBall and yBall arrays
    mov ecx, LENGTHOF xBall2     ; Number of elements in xBall and yBall arrays

ClearLoop:
    cmp esi, ecx                ; Check if we reached the end of the arrays
    jge Done                    ; If yes, exit the loop

    ; Load x and y coordinates
    mov dl, [xBall2 + esi]       ; Get x-coordinate
    mov dh, [yBall2 + esi]       ; Get y-coordinate
    call Gotoxy                 ; Move cursor to (x, y)

    ; Set color to Black + (Black * 16)
    mov eax, 0                  ; 0 = Black + (Black * 16)
    call SetTextColor           ; Set the text color to black

    ; Print a space to "clear" the position
    mov al, ' '                 ; Character to print (space)
    call WriteChar              ; Write the character at the position

    inc esi                     ; Move to the next index
    jmp ClearLoop               ; Repeat the loop

Done:
    mov esi , 0

    mov ebx,0
    mov bl,index
    l1:
    mov dl, [xBall2 + ebx]   
    mov dh, [yBall2 + ebx] 
    call CheckCharacter
    
    call Gotoxy 
    mov edx,eax
    mov eax,0
    mov al,[color2 + esi]
    cmp al,0
    je l2
    mov [walls2+edx],"@"
	call SetTextColor
    mov al, "@"
    call WriteChar
    l2:
    inc esi
    dec ebx
    cmp ebx,0
    jge l1

    inc index
    ret
DrawBall2 ENDP


AddElementShift2 PROC
    ; Input: AL = value to add, BL = index where to insert

    mov ecx, 0                ; Load current count into ECX for the loop
    mov cl,colorCount
    ;dec ecx                    ; Start from the last valid element
    mov esi , ecx
    dec esi
    sub ecx,ebx

    shift_loop:
    mov dl, [color2 + esi]      ; Load element at index ECX
    mov [color2 + esi + 1], dl  ; Move it forward
    dec esi
    loop shift_loop           ; Decrement ECX and continue

    ; Insert the new element
    mov eax,0
    mov al , fire_color
    mov [color2 + ebx], al     ; Place the new value at the specified index

    ; Update the count
    inc colorCount     ; Increment the count of elements
    
    jmp done


    done:
    ret
AddElementShift2 ENDP


TripleCheck2 PROC
    mov esi, 0               ; Index pointer for the array
    mov edi, 0               ; Write pointer for the modified array
    mov ecx, LENGTHOF color2  ; Total number of elements in the array
    mov found, 0             ; Flag to indicate if a triplet has been found (0 = no, 1 = yes)

CheckNextTriple:
    ; Check if we've reached the end of the array
    cmp esi, ecx
    jge Done                 ; If at the end, exit

    ; If a triplet is found
    cmp found, 1             ; Have we already found a triplet?
    je NotTriple             ; If yes, skip processing further triplets

    ; Check for three consecutive elements
    mov al, [color2 + esi]    ; Load current element
    cmp al, [color2 + esi + 1]
    jne NotTriple            ; If not equal, move to next element
    cmp al, [color2 + esi + 2]
    jne NotTriple            ; If not equal, move to next element
    cmp al, 0
    je Done                  ; If zero, exit

    

    ; Process the first triplet found
    mov found, 1             ; Set the flag to indicate a triplet has been found
    add esi, 3               ; Move the index pointer forward by 3 (skip triplet)
    sub index, 3             ; Decrease the index count
    sub colorCount, 3        ; Decrease the color count
    add score, 30            ; Increment the score
    jmp CheckNextTriple      ; Continue checking the rest of the array

NotTriple:
    ; If not a triplet or triplet already processed, copy the element
    mov al, [color2 + esi]    ; Load current element
    mov [color2 + edi], al    ; Store it at the write pointer
    inc esi                  ; Move to the next element
    inc edi                  ; Move the write pointer forward
    jmp CheckNextTriple

Done:
    ; Fill the rest of the array with 0 to clear unused space
    mov eax, 0
FillRest:
    cmp edi, ecx
    jge Finish
    mov [color2 + edi], al    ; Clear the unused elements
    inc edi
    jmp FillRest

Finish:
    call ClearBallPositions2  ; Call external functions
    call DrawBall2
    ret
TripleCheck2 ENDP

ClearBallPositions2 PROC
    mov esi, 0                  ; Index for the xBall and yBall arrays
    mov ecx, LENGTHOF xBall2     ; Number of elements in xBall and yBall arrays

ClearLoop:
    cmp esi, ecx                ; Check if we reached the end of the arrays
    jge Done                    ; If yes, exit the loop

    ; Load x and y coordinates
    mov dl, [xBall2 + esi]       ; Get x-coordinate
    mov dh, [yBall2 + esi]       ; Get y-coordinate
    call CheckCharacter
    mov [walls2+eax]," "
    call Gotoxy                 ; Move cursor to (x, y)

    ; Set color to Black + (Black * 16)
    mov eax, 0                  ; 0 = Black + (Black * 16)
    call SetTextColor           ; Set the text color to black

    ; Print a space to "clear" the position
    mov al, ' '                 ; Character to print (space)
    call WriteChar              ; Write the character at the position

    inc esi                     ; Move to the next index
    jmp ClearLoop               ; Repeat the loop

Done:
    ret
ClearBallPositions2 ENDP


changeFireBallColor2 PROC

    generate_random:
    mov ecx, 4        ; Set ECX to 3 (upper limit)
    rdtsc            ; Read the time-stamp counter into EDX:EAX
    xor edx, edx     ; Clear EDX
    div ecx          ; Divide EDX:EAX by ECX, quotient in EAX, remainder in EDX
    mov eax, edx     ; Move remainder (random number) to EAX
    
    cmp eax, 0
    jne next
    mov fire_color,68
    mov Player_color,4
    jmp return
    
    next:
    cmp eax, 1
    jne next1
    mov fire_color,34
    mov Player_color,2
    jmp return
    
    next1:
    cmp eax, 2
    jne next2
    mov fire_color,102
    mov Player_color,6
    jmp return

    next2:
    mov fire_color,85
    mov Player_color,5
    jmp return

    return:


    ret
changeFireBallColor2 ENDP


Erase PROC
    mov eax,0
    mov al,BonusIndex
	mov dl , [xBonus + eax]
	mov dh , [yBonus + eax]
	call Gotoxy
	mov eax,black+(black*16)
	call SetTextColor
	mov al," "
	call WriteChar

    inc BonusIndex
    cmp BonusIndex,8
    jne done
    mov BonusIndex, 0
    done:
    ret
Erase ENDP

DrawBonus PROC
    cmp firsttime ,1 
    je done

    call Erase
    done:

    mov eax,0
    mov al,BonusIndex
	mov dl , [xBonus + eax]
	mov dh , [yBonus + eax]
	call Gotoxy
	mov eax,white+(13*16)
	call SetTextColor
	mov al,"$"
	call WriteChar

    ret
DrawBonus ENDP

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DrawWall3 PROC
    call clrscr

    mov eax, White + (Black * 16)
        call SetTextColor
        mov dl, 55
        mov dh, 2
        call Gotoxy
        mWrite "LEVEL "

        mov al, level
        call WriteDec

    mov eax, Gray + (Black * 16)
    call SetTextColor
    mov dl, 19
    mov dh, 4
    call Gotoxy

    mov esi, offset walls3
    mov counter1, 23
    mov counter2, 79
    movzx ecx, counter1

printcolumn:
    mov counter1, cl
    movzx ecx, counter2

printrow:
    mov eax, [esi]
    cmp al , "|"
    jne next
    mov eax, blue + (blue * 16)
    call SetTextColor
    next:
    cmp al , "X"
    jne next2
    mov eax, white + (blue * 16)
    call SetTextColor
    next2:
    cmp al , "-"
    jne next3
    mov eax, black + (white * 16)
    call SetTextColor
    next3:
    mov eax, [esi]
    call WriteChar
    mov eax, Gray + (Black * 16)
    call SetTextColor
    inc esi
    loop printrow

    movzx ecx, counter1
    mov dl, 19
    inc dh
    call Gotoxy
    loop printcolumn

    ret
DrawWall3 ENDP



checkCollision3 PROC

    mov eax,0
    mov al,BonusIndex
    cmp dl,[xBonus3+eax]
    jne noBonus
    cmp dh,[yBonus3+eax]
    jne noBonus
    call Erase3
    add score,100
    jmp clear1

    noBonus:

    
    call CheckCharacter  ; Get the character at (112, 15)
    cmp dl,32
    jne normal
    cmp dh,15
    jne normal
    add eax , 79
    normal:
    cmp [walls3+eax],"@"
    jne clear2


    ; Check specific locations one by one
    cmp dl, 53       ; Check x-coordinate for (53, 9)
    jne check_50_6
    cmp dh, 9
    je loc_53_9      ; Jump if (53, 9) matches
    jmp check_50_6   ; Continue checking if not

 check_50_6:
    cmp dl, 50       ; Check x-coordinate for (59, 9)
    jne check_59_9
    cmp dh, 6
    je loc_50_6      ; Jump if (59, 9) matches
    jmp check_59_9


 check_59_9:
    cmp dl, 59       ; Check x-coordinate for (59, 9)
    jne check_59_6
    cmp dh, 9
    je loc_59_9      ; Jump if (59, 9) matches
    jmp check_59_6

check_59_6:
    cmp dl, 59       ; Check x-coordinate for (59, 9)
    jne check_65_9
    cmp dh, 6
    je loc_59_6      ; Jump if (59, 9) matches
    jmp check_65_9



check_65_9:
    cmp dl, 65       ; Check x-coordinate for (65, 9)
    jne check_68_6
    cmp dh, 9
    je loc_65_9      ; Jump if (65, 9) matches
    jmp check_68_6

check_68_6:
    cmp dl, 68       ; Check x-coordinate for (65, 9)
    jne check_53_21
    cmp dh, 6
    je loc_68_6      ; Jump if (65, 9) matches
    jmp check_53_21


check_53_21:
    cmp dl, 53       ; Check x-coordinate for (53, 21)
    jne check_50_24
    cmp dh, 21
    je loc_53_21     ; Jump if (53, 21) matches
    jmp check_50_24

check_50_24:
    cmp dl, 50       ; Check x-coordinate for (53, 21)
    jne check_59_21
    cmp dh, 24
    je loc_50_24    ; Jump if (53, 21) matches
    jmp check_59_21



check_59_21:
    cmp dl, 59       ; Check x-coordinate for (59, 21)
    jne check_59_24
    cmp dh, 21
    je loc_59_21     ; Jump if (59, 21) matches
    jmp check_59_24

check_59_24:
    cmp dl, 59       ; Check x-coordinate for (59, 21)
    jne check_65_21
    cmp dh, 24
    je loc_59_24     ; Jump if (59, 21) matches
    jmp check_65_21



check_65_21:
    cmp dl, 65       ; Check x-coordinate for (65, 21)
    jne check_68_24
    cmp dh, 21
    je loc_65_21     ; Jump if (65, 21) matches
    jmp check_68_24

check_68_24:
    cmp dl, 68       ; Check x-coordinate for (65, 21)
    jne check_77_15
    cmp dh, 24
    je loc_68_24     ; Jump if (65, 21) matches
    jmp check_77_15



check_77_15:
    cmp dl, 77       ; Check x-coordinate for (77, 15)
    jne check_41_15
    cmp dh, 15
    je loc_77_15     ; Jump if (77, 15) matches
    jmp check_41_15

check_41_15:
    cmp dl, 41       ; Check x-coordinate for (41, 15)
    jne check_32_15 
    cmp dh, 15
    je loc_32_15     ; Jump if (41, 15) matches
    jmp check_32_15

check_32_15:
    cmp dl, 32       ; Check x-coordinate for (41, 15)
    jne clear2
    cmp dh, 15
    je loc_32_15     ; Jump if (41, 15) matches
    jmp clear2

; Label for specific locations
loc_53_9:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l1:
    cmp [xBall3 + eax], 53
    jne l2
    cmp [yBall3 + eax], 9
    jne l2
    call AddElementShift3
    jmp clear

    l2:
    dec eax
    inc ebx
    jmp l1


loc_59_9:
   mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l3:
    cmp [xBall3 + eax], 59
    jne l4
    cmp [yBall3 + eax], 9
    jne l4
    call AddElementShift3
    jmp clear

    l4:
    dec eax
    inc ebx
    jmp l3

    

loc_65_9:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l5:
    cmp [xBall3 + eax], 65
    jne l6
    cmp [yBall3 + eax], 9
    jne l6
    call AddElementShift3
    jmp clear

    l6:
    dec eax
    inc ebx
    jmp l5

   

loc_53_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l7:
    cmp [xBall3 + eax], 53
    jne l8
    cmp [yBall3 + eax], 21
    jne l8
    call AddElementShift3
    jmp clear

    l8:
    dec eax
    inc ebx
    jmp l7

   

loc_59_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l9:
    cmp [xBall3 + eax], 59
    jne l10
    cmp [yBall3 + eax], 21
    jne l10
    call AddElementShift3
    jmp clear

    l10:
    dec eax
    inc ebx
    jmp l9

loc_65_21:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l11:
    cmp [xBall3 + eax], 65
    jne l12
    cmp [yBall3 + eax], 21
    jne l12
    call AddElementShift3
    jmp clear

    l12:
    dec eax
    inc ebx
    jmp l11

loc_77_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l13:
    cmp [xBall3 + eax], 77
    jne l14
    cmp [yBall3 + eax], 15
    jne l14
    call AddElementShift3
    jmp clear

    l14:
    dec eax
    inc ebx
    jmp l13


loc_41_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l15:
    cmp [xBall3 + eax], 41
    jne l16
    cmp [yBall3 + eax], 15
    jne l16
    call AddElementShift3
    jmp clear

    l16:
    dec eax
    inc ebx
    jmp l15

loc_32_15:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l17:
    cmp [xBall3 + eax], 32
    jne l18
    cmp [yBall3 + eax], 16
    jne l18
    call AddElementShift3
    jmp clear

    l18:
    dec eax
    inc ebx
    jmp l17   

loc_50_6:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l19:
    cmp [xBall3 + eax], 50
    jne l20
    cmp [yBall3 + eax], 6
    jne l20
    call AddElementShift3
    jmp clear

    l20:
    dec eax
    inc ebx
    jmp l19   

loc_59_6:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l21:
    cmp [xBall3 + eax], 59
    jne l22
    cmp [yBall3 + eax], 6
    jne l22
    call AddElementShift3
    jmp clear

    l22:
    dec eax
    inc ebx
    jmp l21  

loc_68_6:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l23:
    cmp [xBall3 + eax], 68
    jne l24
    cmp [yBall3 + eax], 6
    jne l24
    call AddElementShift3
    jmp clear

    l24:
    dec eax
    inc ebx
    jmp l23  

loc_68_24:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l25:
    cmp [xBall3 + eax], 68
    jne l26
    cmp [yBall3 + eax], 24
    jne l26
    call AddElementShift3
    jmp clear

    l26:
    dec eax
    inc ebx
    jmp l25 

loc_59_24:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l27:
    cmp [xBall3 + eax], 59
    jne l28
    cmp [yBall3 + eax], 24
    jne l28
    call AddElementShift3
    jmp clear

    l28:
    dec eax
    inc ebx
    jmp l27  

loc_50_24:
    mov eax,0
    mov al , index
    dec eax
    mov ebx,0

    l29:
    cmp [xBall3 + eax], 50
    jne l30
    cmp [yBall3 + eax], 24
    jne l30
    call AddElementShift3
    jmp clear

    l30:
    dec eax
    inc ebx
    jmp l29 

clear:
mov dx,0
call TripleCheck3
clear1:
mov dx,0
clear2:
    
    ret
checkCollision3 ENDP

DrawBall3 PROC


    mov esi, 0                  ; Index for the xBall and yBall arrays
    mov ecx, LENGTHOF xBall3     ; Number of elements in xBall and yBall arrays

ClearLoop:
    cmp esi, ecx                ; Check if we reached the end of the arrays
    jge Done                    ; If yes, exit the loop

    ; Load x and y coordinates
    mov dl, [xBall3 + esi]       ; Get x-coordinate
    mov dh, [yBall3 + esi]       ; Get y-coordinate
    call Gotoxy                 ; Move cursor to (x, y)

    ; Set color to Black + (Black * 16)
    mov eax, 0                  ; 0 = Black + (Black * 16)
    call SetTextColor           ; Set the text color to black

    ; Print a space to "clear" the position
    mov al, ' '                 ; Character to print (space)
    call WriteChar              ; Write the character at the position

    inc esi                     ; Move to the next index
    jmp ClearLoop               ; Repeat the loop
Done:

 mov esi , 0

    mov ebx,0
    mov bl,index
    l1:
    mov dl, [xBall3 + ebx]   
    mov dh, [yBall3 + ebx] 
    call CheckCharacter
    
    call Gotoxy 
    mov edx,eax
    mov eax,0
    mov al,[color3 + esi]
    cmp al,0
    je l2
    mov [walls3+edx],"@"
	call SetTextColor
    mov al, "@"
    call WriteChar
    l2:
    inc esi
    dec ebx
    cmp ebx,0
    jge l1

    inc index

    ret
DrawBall3 ENDP


AddElementShift3 PROC
    ; Input: AL = value to add, BL = index where to insert

    mov ecx, 0                ; Load current count into ECX for the loop
    mov cl,colorCount
    ;dec ecx                    ; Start from the last valid element
    mov esi , ecx
    dec esi
    sub ecx,ebx

    shift_loop:
    mov dl, [color3 + esi]      ; Load element at index ECX
    mov [color3 + esi + 1], dl  ; Move it forward
    dec esi
    loop shift_loop           ; Decrement ECX and continue

    ; Insert the new element
    mov eax,0
    mov al , fire_color
    mov [color3 + ebx], al     ; Place the new value at the specified index

    ; Update the count
    inc colorCount     ; Increment the count of elements
    
    jmp done


    done:
    cmp fire_color , 255
    jne done2
    mov ecx,0
    mov cl,colorCount
    call RemoveSeven
    done2:
    ret
AddElementShift3 ENDP

RemoveSeven PROC
    ; Input: EBX = index to remove from, ECX = total length of the array
    push esi             ; Save registers
    push edi
    push eax
    push edx

    mov esi, 0           ; Start reading from the beginning of the array
    mov edi, 0           ; Write pointer for compacted array

    ; Calculate the removal range
    mov eax, ebx         ; Copy index
    sub eax, 2           ; Start from 2 elements backward
    cmp eax, 0           ; Ensure start is not below 0
    jl SetStartToZero    ; If out of bounds, adjust to start at 0
    jmp SetStart

SetStartToZero:
    mov eax, 0           ; Adjust start to 0

SetStart:
    mov edx, ebx         ; Copy index for end calculation
    add edx, 2           ; End at 2 elements forward
    cmp edx, ecx         ; Ensure end is not beyond the array length
    jl SetEnd            ; If within bounds, continue
    mov edx, ecx         ; Adjust end to array length

SetEnd:
    ; Traverse the array and copy elements outside the removal range
ArrayTraverse:
    cmp esi, ecx         ; Check if the end of the array is reached
    jge FillZeros        ; If so, proceed to fill unused spaces

    ; Check if the current index is outside the removal range
    cmp esi, eax         ; Is the current index before the start of removal?
    jl CopyElement       ; If yes, copy it
    cmp esi, edx         ; Is the current index after the end of removal?
    jg CopyElement      ; If yes, copy it

    ; Skip the element (do not copy)
    jmp NextElement

CopyElement:
    ; Copy the current element to the new position
    mov bl, [color3 + esi] ; Load the current element
    mov [color3 + edi], bl ; Write it to the compacted array
    inc edi                ; Move the write pointer forward

NextElement:
    inc esi                ; Move the read pointer forward
    jmp ArrayTraverse      ; Repeat for next element

FillZeros:
    ; Fill the remaining part of the array with zeros
    mov al, 0
    cmp edi, ecx
    jge Done               ; If all remaining spaces are filled, exit

FillRemaining:
    mov [color3 + edi], al
    inc edi
    jmp FillZeros

Done:
    sub edx,  eax    ; Adjust the total length by the number of removed elements
    sub index,dl
    add score,120 
    pop edx                 ; Restore registers
    pop eax
    pop edi
    pop esi
    ret
RemoveSeven ENDP



TripleCheck3 PROC
    mov esi, 0               ; Index pointer for the array
    mov edi, 0               ; Write pointer for the modified array
    mov ecx, LENGTHOF color3  ; Total number of elements in the array
    mov found, 0             ; Flag to indicate if a triplet has been found (0 = no, 1 = yes)

CheckNextTriple:
    ; Check if we've reached the end of the array
    cmp esi, ecx
    jge Done                 ; If at the end, exit

    ; If a triplet is found
    cmp found, 1             ; Have we already found a triplet?
    je NotTriple             ; If yes, skip processing further triplets

    ; Check for three consecutive elements
    mov al, [color3 + esi]    ; Load current element
    cmp al, [color3 + esi + 1]
    jne NotTriple            ; If not equal, move to next element
    cmp al, [color3 + esi + 2]
    jne NotTriple            ; If not equal, move to next element
    cmp al, 0
    je Done                  ; If zero, exit

    

    ; Process the first triplet found
    mov found, 1             ; Set the flag to indicate a triplet has been found
    add esi, 3               ; Move the index pointer forward by 3 (skip triplet)
    sub index, 3             ; Decrease the index count
    sub colorCount, 3        ; Decrease the color count
    add score, 30            ; Increment the score
    jmp CheckNextTriple      ; Continue checking the rest of the array

NotTriple:
    ; If not a triplet or triplet already processed, copy the element
    mov al, [color3 + esi]    ; Load current element
    mov [color3 + edi], al    ; Store it at the write pointer
    inc esi                  ; Move to the next element
    inc edi                  ; Move the write pointer forward
    jmp CheckNextTriple

Done:
    ; Fill the rest of the array with 0 to clear unused space
    mov eax, 0
FillRest:
    cmp edi, ecx
    jge Finish
    mov [color3 + edi], al    ; Clear the unused elements
    inc edi
    jmp FillRest

Finish:
    call ClearBallPositions3  ; Call external functions
    call DrawBall3
    ret
TripleCheck3 ENDP

ClearBallPositions3 PROC
    mov esi, 0                  ; Index for the xBall and yBall arrays
    mov ecx, LENGTHOF xBall3     ; Number of elements in xBall and yBall arrays

ClearLoop:
    cmp esi, ecx                ; Check if we reached the end of the arrays
    jge Done                    ; If yes, exit the loop

    ; Load x and y coordinates
    mov dl, [xBall3 + esi]       ; Get x-coordinate
    mov dh, [yBall3 + esi]       ; Get y-coordinate
    call CheckCharacter
    mov [walls3+eax]," "
    call Gotoxy                 ; Move cursor to (x, y)

    ; Set color to Black + (Black * 16)
    mov eax, 0                  ; 0 = Black + (Black * 16)
    call SetTextColor           ; Set the text color to black

    ; Print a space to "clear" the position
    mov al, ' '                 ; Character to print (space)
    call WriteChar              ; Write the character at the position

    inc esi                     ; Move to the next index
    jmp ClearLoop               ; Repeat the loop

Done:
    ret
ClearBallPositions3 ENDP


changeFireBallColor3 PROC

    generate_random:
    mov ecx, 6        ; Set ECX to 3 (upper limit)
    rdtsc            ; Read the time-stamp counter into EDX:EAX
    xor edx, edx     ; Clear EDX
    div ecx          ; Divide EDX:EAX by ECX, quotient in EAX, remainder in EDX
    mov eax, edx     ; Move remainder (random number) to EAX
    
    cmp eax, 0
    jne next
    mov fire_color,68
    mov Player_color,4
    jmp return
    
    next:
    cmp eax, 1
    jne next1
    mov fire_color,34
    mov Player_color,2
    jmp return
    
    next1:
    cmp eax, 2
    jne next2
    mov fire_color,102
    mov Player_color,6
    jmp return

    next2:
    cmp eax, 3
    jne next3
    mov fire_color,187
    mov Player_color,11
    jmp return

    next3:
    cmp eax, 4
    jne next3
    mov fire_color,255
    mov Player_color,15
    jmp return

    next4:
    mov fire_color,85
    mov Player_color,5
    jmp return

    return:


    ret
changeFireBallColor3 ENDP



Erase3 PROC
    mov eax,0
    mov al,BonusIndex
	mov dl , [xBonus3 + eax]
	mov dh , [yBonus3 + eax]
	call Gotoxy
	mov eax,black+(black*16)
	call SetTextColor
	mov al," "
	call WriteChar

    inc BonusIndex
    cmp BonusIndex,6
    jne done
    mov BonusIndex, 0
    done:
    ret
Erase3 ENDP

DrawBonus3 PROC
    cmp firsttime ,1 
    je done

    call Erase3
    done:

    mov eax,0
    mov al,BonusIndex
	mov dl , [xBonus3 + eax]
	mov dh , [yBonus3 + eax]
	call Gotoxy
	mov eax,white+(13*16)
	call SetTextColor
	mov al,"$"
	call WriteChar

    ret
DrawBonus3 ENDP

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




Page1 PROC

mov eax,black+(black*16)
	call SetTextColor
call clrscr
	mov dl,0
	mov dh,4
	call Gotoxy
	mov edi , 0
	
	
 	l1:
	cmp [GameName+edi] , "*"
	jne nextCharacter1
	mov eax,yellow+(black*16)
	call SetTextColor
	mov al , "*"
	call WriteChar
	jmp nextChar

	nextCharacter1:
	cmp [GameName+edi] , "|"
	jne nextCharacter2
	mov eax,blue+(blue*16)
	call SetTextColor
	mov al , "|"
	call WriteChar
	jmp nextChar

	nextCharacter2:
	cmp [GameName+edi] , "-"

	jne nextCharacter3
	mov eax,red+(red*16)
	call SetTextColor
	mov al , "-"
	call WriteChar
	jmp nextChar

	nextCharacter3:
	cmp [GameName+edi] , "_"
	jne nextCharacter4
	mov eax,green+(green*16)
	call SetTextColor
	mov al , "_"
	call WriteChar
	jmp nextChar

	nextCharacter4:
	cmp [GameName+edi] , "!"
	jne nextCharacter5
	mov eax,brown+(brown*16)
	call SetTextColor
	mov al , "!"
	call WriteChar
	jmp nextChar

	nextCharacter5:
	cmp [GameName+edi] , "&"
	jne nextCharacter6
	mov eax,magenta+(magenta*16)
	call SetTextColor
	mov al , "&"
	call WriteChar
	jmp nextChar

	nextCharacter6:
	cmp [GameName+edi] , "+"
	jne nextCharacter7
	mov eax,11+(11*16)
	call SetTextColor
	mov al , "+"
	call WriteChar
	jmp nextChar

	nextCharacter7:
	cmp [GameName+edi] , " "
	jne nextChar
	mov eax,black+(black*16)
	call SetTextColor
	mov al , " "
	call WriteChar
	jmp nextChar

	nextChar:
	inc edi
	mov al ,  [GameName+edi]
	cmp [GameName+edi] , 0
	je return
	cmp [GameName+edi] , 0ah
	jne l1
	inc edi
	jmp l1
	return:

	mov eax ,ecx 
	call SetTextColor	


	mov ebx , 1
	

	ll:
	mov eax , 07
	imul eax ,16
	mov eax, ebx
	mov ecx , eax
	call SetTextColor
	mov dl,50
	mov dh,23
	call Gotoxy
	mov edx,OFFSET nameinput
	call WriteString
	
	inc ebx
	cmp ebx , 16
	jne check
	mov ebx ,0
	check:
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	mov eax , 0
	call Readkey
	cmp al ,0dH
	jne ll
	mov eax ,ecx 
	
	call SetTextColor
	mov dl,50
	mov dh,25
	call Gotoxy
    ;Read input string
    mov edx, offset buffer
    mov ecx, 255
    call ReadString

    mov esi , 0
    start3:
    cmp buffer[esi] , 0
    je exit3
    inc esi
    jmp start3
    exit3:
	mov info , esi
	ret
Page1 ENDP

menuscr PROC
	mov eax,black+(black*16)
	call SetTextColor
	call clrscr
	mov dl,0
	mov dh,4
	call Gotoxy
	mov edi , 0
	
	l1:
	cmp [menustr+edi] , "*"
	jne nextCharacter1
	mov eax,yellow+(black*16)
	call SetTextColor
	mov al , "*"
	call WriteChar
	jmp nextChar

	nextCharacter1:
	cmp [menustr+edi] , "|"
	jne nextCharacter2
	mov eax,blue+(blue*16)
	call SetTextColor
	mov al , "|"
	call WriteChar
	jmp nextChar

	nextCharacter2:
	cmp [menustr+edi] , "-"
	jne nextCharacter3
	mov eax,red+(red*16)
	call SetTextColor
	mov al , "-"
	call WriteChar
	jmp nextChar

	nextCharacter3:
	cmp [menustr+edi] , "_"
	jne nextCharacter4
	mov eax,green+(green*16)
	call SetTextColor
	mov al , "_"
	call WriteChar
	jmp nextChar

	nextCharacter4:
	cmp [menustr+edi] , "+"
	jne nextCharacter5
	mov eax,brown+(brown*16)
	call SetTextColor
	mov al , "+"
	call WriteChar
	jmp nextChar

	nextCharacter5:
	cmp [menustr+edi] , "&"
	jne nextCharacter6
	mov eax,magenta+(magenta*16)
	call SetTextColor
	mov al , "&"
	call WriteChar
	jmp nextChar

	nextCharacter6:
	cmp [menustr+edi] , " "
	jne nextChar
	mov eax,black+(black*16)
	call SetTextColor
	mov al , " "
	call WriteChar
	jmp nextChar

	nextChar:
	inc edi
	mov al ,  [menustr+edi]
	cmp [menustr+edi] , 0
	je return
	cmp [menustr+edi] , 0ah
	jne l1
	inc edi
	jmp l1
	return:

	;mov eax, SND_FILENAME  ; pszSound is a file name
    ;or eax, SND_ASYNC      ; Play in the background

    ;invoke PlaySound, addr playsound1, 0, eax

	mov ebx , 1
	l112:
	mov eax , 07
	imul eax ,16
	mov eax, ebx
	call SetTextColor
	mov dl ,48
	mov dh ,21
	call Gotoxy 
	mov edx,OFFSET StartMsg
	call WriteString
	mov eax, ebx
	add eax ,4
	mov dl ,48
	mov dh ,23
	call Gotoxy
	mov edx,OFFSET InstructMsg
	call WriteString
	mov eax, ebx
	add eax ,2
	call SetTextColor
	mov dl,49
	mov dh,25
	call Gotoxy
	mov edx,OFFSET HistoryMsg
	call WriteString
	inc ebx
	cmp ebx , 12
	jne check
	mov ebx ,0
	check:
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	mov eax , 0
	call Readkey
	cmp al ,1
	je l112
	cmp al , "i"
	je caLLInstruction
	cmp al , 20h
	je startgame
	cmp al , "h"
	je callHistory
	jmp l112
	caLLInstruction:
	call Instruction
	ret
	callHistory:
	call History
	ret
	startgame:

	ret
menuscr ENDP

History PROC
	call ReadFile1
	mov eax,black+(black*16)
	call SetTextColor
	call clrscr
	mov dl,0
	mov dh,1 
	call Gotoxy
	mov eax,white+(12*16)
	call SetTextColor
	mov edx,OFFSET Heading
	call WriteString
	mov dl,0
	mov dh,3 
	call Gotoxy
	mov eax,white+(black*16)
	call SetTextColor
	mov edx,OFFSET AllData
	call WriteString
	;mov eax, SND_FILENAME  ; pszSound is a file name
    ;or eax, SND_ASYNC      ; Play in the background

    ;invoke PlaySound, addr playsound1, 0, eax

	call ReadChar
	call menuscr
ret
History ENDP


Instruction PROC
pushad
	mov eax,black+(black*16)
	call SetTextColor
	call clrscr
	mov dl,0
	mov dh,4
	call Gotoxy
	mov edi , 0
	
	
 	l1:
	

	nextCharacter1:
	cmp [instscr+edi] , "|"
	jne nextCharacter2
	mov eax,blue+(blue*16)
	call SetTextColor
	mov al , "|"
	call WriteChar
	jmp nextChar

	nextCharacter2:
	cmp [instscr+edi] , "-"
	jne nextCharacter3
	mov eax,red+(red*16)
	call SetTextColor
	mov al , "-"
	call WriteChar
	jmp nextChar

	nextCharacter3:
	cmp [instscr+edi] , "_"
	jne nextCharacter4
	mov eax,green+(green*16)
	call SetTextColor
	mov al , "_"
	call WriteChar
	jmp nextChar

	nextCharacter4:
	cmp [instscr+edi] , "!"
	jne nextCharacter5
	mov eax,brown+(brown*16)
	call SetTextColor
	mov al , "!"
	call WriteChar
	jmp nextChar

	

	nextCharacter5:
	cmp [instscr+edi] , " "
	jne nextChar
	mov eax,black+(black*16)
	call SetTextColor
	mov al , " "
	call WriteChar
	jmp nextChar

	nextChar:
	inc edi
	mov al ,  [instscr+edi]
	cmp [instscr+edi] , 0
	je return
	cmp [instscr+edi] , 0ah
	jne l1
	inc edi
	jmp l1
	return:
	;mov eax, SND_FILENAME  ; pszSound is a file name
    ;or eax, SND_ASYNC      ; Play in the background

    ;invoke PlaySound, addr playsound1, 0, eax

	call instructHelper
	call ReadChar
	call menuscr
popad
ret
Instruction ENDP

instructHelper PROC
pushad

	mov dl,0
	mov dh,18
	call Gotoxy
	mov edi , 0
	
	
 	l1:
	
	cmp [instMsg+edi] , "^"
	jne nextCharacter1
	mov eax,black+(green*16)
	call SetTextColor
	mov al , "^"
	call WriteChar
	jmp nextChar

	nextCharacter1:
	cmp [instMsg+edi] , "*"
	jne nextCharacter2
	mov eax,yellow+(black*16)
	call SetTextColor
	mov al , "*"
	call WriteChar
	jmp nextChar
	

	nextCharacter2:
	cmp [instMsg+edi] , "-"
	jne nextCharacter3
	mov eax,black+(red*16)
	call SetTextColor
	mov al , "•"
	call WriteChar
	jmp nextChar

	nextCharacter3:
	cmp [instMsg+edi] , "@"
	jne nextCharacter4
	mov eax,black+(magenta*16)
	call SetTextColor
	mov al , "@"
	call WriteChar
	jmp nextChar

	nextCharacter4:
	cmp [instMsg+edi] , "$"
	jne nextCharacter5
	mov eax,white+(white*16)
	call SetTextColor
	mov al , "$"
	call WriteChar
	jmp nextChar

	nextCharacter5:
	cmp [instMsg+edi] , " "
	jne nextCharacter6
	mov eax,black+(black*16)
	call SetTextColor
	mov al , " "
	call WriteChar
	jmp nextChar

	nextCharacter6:
	cmp [instMsg+edi] , "~"
	jne nextCharacter31
	mov eax,black+(Red*16)
	call SetTextColor
	mov al , "G"
	call WriteChar
	jmp nextChar

	nextCharacter31:
	cmp [instMsg+edi] , "_"
	jne nextCharacter41
	mov eax,black+(green*16)
	call SetTextColor
	mov al , "•"
	call WriteChar
	jmp nextChar

	nextCharacter41:
	cmp [instMsg+edi] , "!"
	jne nextCharacter51
	mov eax,black+(brown*16)
	call SetTextColor
	mov al , "•"
	call WriteChar
	jmp nextChar

	nextCharacter51:
	cmp [instMsg+edi] , 49
	jl nextChar
	mov eax,white+(black*16)
	call SetTextColor
	mov al , [instMsg+edi]
	call WriteChar
	jmp nextChar

	nextChar:
	inc edi
	mov al ,  [instMsg+edi]
	cmp [instMsg+edi] , 0
	je return
	cmp [instMsg+edi] , 0ah
	jne l1
	inc edi
	jmp l1
	return:


popad
ret
instructHelper ENDP


FindIndex PROC
pushad
	mov ecx , AllDataSize
	mov esi , 0
	l1:
		mov bl,AllData[esi]
		cmp AllData[esi] , 0
		je return
		inc index2
		inc esi
	loop l1

	return:
popad
ret
FindIndex ENDP

FinalString PROC
pushad
	mov esi,0
	mov ecx , info
	mov edi , index2
	l1:
	mov eax , 0
	mov  al,buffer[esi]
	mov AllData[edi], al 
	inc esi 
	inc edi
	loop l1
	mov index2 , edi
popad
ret
FinalString ENDP

convert PROC
pushad

    mov ebx, 10          
    mov edi, esi 
	convertLoop:
    xor edx, edx         
    div ebx             
    add dl, 48          
    dec edi              
    mov buffer[edi], dl         

    loop convertLoop

popad
ret
convert ENDP

MakeString PROC
pushad
	mov esi,info
	mov buffer[esi], 09H
	inc esi
	
	add esi , 4
	mov ecx, 4  
	mov eax, score
	call convert
	mov buffer[esi], 09H
	inc esi
	
	add esi, 2
	mov ecx, 2  
	mov eax, 0
	mov al, level 
	call convert
	mov buffer[esi], 0aH
	inc esi 
	mov buffer[esi], 0
	inc esi
	mov info,esi
popad
ret
MakeString ENDP


WriteFile1 Proc
pushAd
		mov edx,OFFSET filename
		call CreateOutputFile
		mov fileHandle,eax
		cmp eax, INVALID_HANDLE_VALUE 
		jne file_ok

		mov edx, OFFSET str1
		call WriteString
		jmp quit

		file_ok:

		; Input a string
		mov eax, fileHandle
		mov edx, OFFSET AllData
		mov ecx, index2
		call WriteToFile ; Write to the file in append mode
		mov bytesWritten, eax
		call CloseFile

	quit:
popAd
ret
WriteFile1 Endp

ReadFile1 Proc
pushAd
		mov edx,OFFSET filename
		call OpenInputFile
		mov fileHandle2,eax
		cmp eax,INVALID_HANDLE_VALUE 
		jne file_ok
		
		jmp quit
	file_ok:
		mov eax, fileHandle2
		mov edx,OFFSET AllData
		mov ecx,AllDataSize
		call ReadFromFile

	close_file:
	mov eax,fileHandle2
	call CloseFile
	quit:
popAd
ret
ReadFile1 Endp


LastPage PROC
	call ExitScr
	mov eax, SND_FILENAME  ; pszSound is a file name
    or eax, SND_ASYNC      ; Play in the background

    invoke PlaySound, addr playsound3, 0, eax

	mov ebx , 1
	l1:
	mov eax , 07
	imul eax ,16
	mov eax, ebx
	call SetTextColor
	mov dl,45
	mov dh,21
	call Gotoxy
	mov edx,OFFSET Heading
	call WriteString
	mov dl,45
	mov dh,23
	call Gotoxy
	mov edx,OFFSET buffer
	call WriteString
	inc ebx
	cmp ebx , 16
	jne check
	mov ebx ,0
	check:
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	call delay
	mov eax , 0
	call Readkey
	cmp al ,1
	je l1
  ret
LastPage Endp



ExitScr PROC
	mov eax,black+(black*16)
	call SetTextColor
	call clrscr
	mov dl,0
	mov dh,4
	call Gotoxy
	mov edi , 0
	
	l1:
	cmp [ExitStr+edi] , "*"
	jne nextCharacter1
	mov eax,yellow+(black*16)
	call SetTextColor
	mov al , "*"
	call WriteChar
	jmp nextChar

	nextCharacter1:
	cmp [ExitStr+edi] , "|"
	jne nextCharacter2
	mov eax,blue+(blue*16)
	call SetTextColor
	mov al , "|"
	call WriteChar
	jmp nextChar

	nextCharacter2:
	cmp [ExitStr+edi] , "-"
	jne nextCharacter3
	mov eax,red+(red*16)
	call SetTextColor
	mov al , "-"
	call WriteChar
	jmp nextChar

	nextCharacter3:
	cmp [ExitStr+edi] , "_"
	jne nextCharacter4
	mov eax,green+(green*16)
	call SetTextColor
	mov al , "_"
	call WriteChar
	jmp nextChar

	nextCharacter4:
	cmp [ExitStr+edi] , "+"
	jne nextCharacter5
	mov eax,brown+(brown*16)
	call SetTextColor
	mov al , "+"
	call WriteChar
	jmp nextChar

	nextCharacter5:
	cmp [ExitStr+edi] , "&"
	jne nextCharacter6
	mov eax,magenta+(magenta*16)
	call SetTextColor
	mov al , "&"
	call WriteChar
	jmp nextChar

	nextCharacter6:
	cmp [ExitStr+edi] , " "
	jne nextChar
	mov eax,black+(black*16)
	call SetTextColor
	mov al , " "
	call WriteChar
	jmp nextChar

	nextChar:
	inc edi
	mov al ,  [ExitStr+edi]
	cmp [ExitStr+edi] , 0
	je return
	cmp [ExitStr+edi] , 0ah
	jne l1
	inc edi
	jmp l1
	return:
	ret
ExitScr ENDP


END main
