



data segment
    ; add your data here!
    
    
    ; Variables storing all the questions
    question1 db "Who was the first president of the USA?$"   
    question2 db "In what year did World War 2 end?$"
    question3 db "Which ancient civilization built the Pyramid?$"
    question4 db "Who was the longest-reigning British monarch?$" 
    question5 db "What year did the Berlin Wall fall?$"
    question6 db "What is the closest planet to the Sun?$"
    question7 db "What gas do plants absorb during photosynthesis?$"
    question8 db "Who developed the theory of relativity?$"
    question9 db "Who discovered penicillin?$"
    question10 db "What is the Latin Name for Gold?$"
    question11 db "What is the capital city of India?$"
    question12 db "What is the capital of Brazil?$"
    question13 db "What is the capital of Australia?$"
    question14 db "What is the capital of Argentina?$"
    question15 db "What is the capital of Azerbaijan?$"
    question16 db "In which sport do players aim to score goals using a stick and a puck?$"
    question17 db "Which country has won the most FIFA World Cup titles?$"
    question18 db "What is the national sport of England?$"
    question19 db "Which player has won the most gold medals in Olympics?$"
    question20 db "Who has the most world chess championship titles?$"

    
    ; Array storing the starting address of the quetions                                                                                                                                                                                                  
    question dw offset question1, offset question2, offset question3, offset question4, offset question5, offset question6, offset question7, offset question8, offset question9, offset question10, offset question11, offset question12, offset question13, offset question14, offset question15, offset question16, offset question17, offset question18, offset question19, offset question20

    
    ;Variables storing all the answers
    options1 db "A) George Washington B) Barack Obama C) Thomas Jefferson$"   
    options2 db "A) 1950 B) 1945 C) 1940$"
    options3 db "A) Persian B) Roman C) Egyptian$"
    options4 db "A) Victoria B) Elizabeth C) Charles$" 
    options5 db "A) 1989  B) 1990 C) 1985$"
    options6 db "A) Mars B) Jupiter C) Mercury$"
    options7 db "A) Oxygen B) Carbon Dioxide C) Nitrogen$"
    options8 db "A) Newton B) Lavoisier C) Einstein$"
    options9 db "A) Fleming B) Boyle C) Gauss$"
    options10 db "A) Argentum B) Plumbum C) Aurum$"
    options11 db "A) New Delhi B) Mumbai C) Chennai$"
    options12 db "A) Brasilia B) Rio de Janeiro  C) Sao Paulo$"
    options13 db "A) Melbourne B) Canberra C) Sydney$"
    options14 db "A) Buenos Aires B) Rio de Janeiro C) Salta$"
    options15 db "A) Shirvan B) Sheki C) Baku$"
    options16 db "A) Hockey  B) Badminton  C) Cricket$"
    options17 db "A) France   B) Brazil  C) Germany$"
    options18 db "A) Football  B) Basketball  C) Cricket$"
    options19 db "A) Michael Phelps  B) Carl Lewis  C) Usain Bolt$"
    options20 db "A) Magnus Carlsen  b) Bobby Fischer  C) Garry Kasparov$"
    
                                                                                                                                                                                                      
    ; Array storing the starting address of the options
    options dw offset options1, offset options2, offset options3, offset options4, offset options5, offset options6, offset options7, offset options8, offset options9, offset options10, offset options11, offset options12, offset options13, offset options14, offset options15, offset options16, offset options17, offset options18, offset options19, offset options20


    
    ;Array storing the actual correct answers of the questions
    correct_answers db 0,1,2,1,0,2,1,2,0,2,0,0,1,0,2,0,1,2,0,2  
    
    
    
    ; Array storing the picked questions by random choices
    question_picked db 20 dup(0)  
    
   
   
    ;Weights associated with each question
    weights db  1,2,1,3,3,1,1,2,3,3,1,1,2,3,3,1,1,2,3,3    
    
    
   
    ;Answers provided by the player
   given_answers db 10 dup(0)  
   
   
   
   ;Total score attined by the player
   total_score dw 0
   
   
   ;total weight of the quetions answered by the player
   total_weight dw 0        
   
   
   
   
   
   ;All the necessary strings for printing
   lets_begin dw "Lets Start The Quiz!$"
   enter_key dw "Press Enter to start$" 
   case dw "Please note that the inputs are case sensetive.Enter your answers in uppercase ONLY.$"
   now_correct dw "Congrats You Answer is Correct$"
   now_wrong dw "Sorry Incorrect Answer$"
   continue dw "Press Enter to Continue$"
    
   
   History_bad dw "Poor in History$"
   History_good dw "Good in History$"
                                      
     WorldCapitals_bad dw "Poor in World Capitals$"
   WorldCapitals_good dw "Good in WorldCapitals$"
   
     Science_bad dw "Poor in Science$"
   Science_good dw "Good in Science$"
   
     Sports_bad dw "Poor in Sports$"
   Sports_good dw "Good in Sports$"
   
   Best_Comment dw "You have aced this quiz. Well Done!$"
    
   Final_Comments dw "Press R to play again or press enter to exit$" 
   
   Achieved dw "Your Score is:$"
   
   Performance dw "Your Performance is: $"   
   
   Answer dw "Answer: $"
                                                                                       
                                                                                       
    
    
    
    

ends 



              
              
              
              
              
              
              
              
              



stack segment
    dw   128  dup(0)
ends







    
    
    
    
    
    
    




code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

     
    
    
    
    ;Print Lets Start
    mov ah,9
    lea dx,lets_begin
    int 21h 
    mov ax,0
    mov dx,0
    
   
    call new_line   
    
    
    ;Print Caution 
    mov ah,9
    lea dx,case
    int 21h 
    mov ax,0
    mov dx,0
    
   
    call new_line  
    
    
    ;Print Press Enter
    mov ah,9
    lea dx,enter_key 
    int 21h
    mov ah,1
    int 21h 
    mov ax,0
    mov dx,0 
    
    
    
    Begin:

    ;SI register stores the round number
    mov si,0
    
        Game: 
        
            
           ; We jump to that corresponding level to execute a question of a specific category
           cmp si,0
           je Question_0            ; Will be a history based question
           cmp si,1
           je Question_1            ; Will be a science based question
           cmp si,2
           je Question_2            ; Will be a World Capital based question
           cmp si,3
           je Question_3            ; Will be a sports based question
           cmp si,4
           je Question_4            ; Will be a World Capital based question
           cmp si,5                  
           je Question_5            ; Will be a science based question
           cmp si,6                 
           je Question_6            ; Will be a sports based question
           cmp si,7
           je Question_7            ; Will be a World Capital based question
           cmp si,8
           je Question_8            ; Will be a science based question
           cmp si,9
           je Question_9            ; Will be a history based question

           
           
           ; After all the questions are executed , we jump top the Evalution level to evaluate the results.
           jmp Evaluation 
           
           
           
           
           
           
                Question_0:  
                   
                   
                   Fetch_0:
                   mov bh, 0 ; lower bound
                   mov bl, 4 ; upper bound
                   call get_random_number  ;dl has the random number now
                   mov dh,0
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_0                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                  ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   
                     
                
                
                
                Question_1: 
                           
                           
                   Fetch_1:  
                   mov bh, 5 ; lower bound
                   mov bl, 9 ; upper bound
                   call get_random_number  ;dl has the random number now 
                   mov dh,0 
                   
                   
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_1                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                   ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game

                
               
               
               
                Question_2:   
                
                
                   Fetch_2:
                   mov bh, 10 ; lower bound
                   mov bl, 14 ; upper bound
                   call get_random_number  ;dl has the random number now
                   mov dh,0 
                   
                   
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_2                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                  
                  ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   
                   

              
               
                Question_3:  
                
                
                   Fetch_3: 
                   mov bh, 15; lower bound
                   mov bl, 19; upper bound
                   call get_random_number  ;dl has the random number now               
                   mov dh,0  
                   
                   
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_3                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                   
                   
                   
                   ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game  
                   
                   

                
                
                Question_4:  
                
                
                   Fetch_4:
                   mov bh, 10 ; lower bound
                   mov bl, 14 ; upper bound
                   call get_random_number  ;dl has the random number now               
                   mov dh,0    
                   
                 
                 
                 
                 
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_4                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                 
                 
                 
                 
                 
                 
                 
                 ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   
                   
                   
                            
               
                Question_5:   
                
                
                   Fetch_5:
                   mov bh, 5 ; lower bound
                   mov bl, 9 ; upper bound
                   call get_random_number  ;dl has the random number now                
                   mov dh,0     
                   
                   
                   
                   
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_5                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                   
                   
                   
                   
                   
                   
                   ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   
                   
                   
                  
 
                
                
                Question_6:    
                
                
                   Fetch_6:
                   mov bh, 15 ; lower bound
                   mov bl, 19 ; upper bound
                   call get_random_number  ;dl has the random number now                
                   mov dh,0  
                   
                  
                  
                  
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_6                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                  
                  
                  
                  
                  
                  ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   

        
        
        
                Question_7:   
 
 
                
                
                   Fetch_7:
                   mov bh, 10 ; lower bound
                   mov bl, 14 ; upper bound
                   call get_random_number  ;dl has the random number now                
                   mov dh,0 
                   
                  
                  
                  
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_7                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1
                  
                  
                  
                  
                  ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   
                   
                
 
 
                Question_8: 
                
                
                   Fetch_8:
                   mov bh, 5 ; lower bound
                   mov bl, 9 ; upper bound
                   call get_random_number  ;dl has the random number now                
                   mov dh,0 
                   
                   
                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_8                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1                   
                   
                   
                   
                   ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   
                   
              
 
 
                Question_9:   
                
                
                
                   Fetch_9:
                   mov bh, 0 ; lower bound
                   mov bl, 4 ; upper bound
                   call get_random_number  ;dl has the random number now                
                   mov dh,0 




                   mov di,dx 
                   cmp question_picked[di],1
                   je Fetch_9                      ; If a question is already picked it will just back to pick a new question
                   mov question_picked[di],1                   
                  ; This function will print the question , receive the answer and update the necessary variables
                   call run_evaluation
                   

                   ; jump back to game start for the execution of the next round
                   jmp Game
                   
  
    
    
    
   
   
                Evaluation: 
                
                        mov ax,0
                        mov bx,0
                        mov cx,0
                        mov dx,0 
                        
                        
                       ;Calculation of total score     (Total score/total weight)*100
                        mov ax,total_score
                        mov cl,100
                        mul cl
                        
                        mov dx,total_weight
                        div dl
                        
                        cmp al,100
                        je Full_Marks
                        mov bl,al
                        
                        lea dx,Achieved
                        mov ah,9
                        int 21h
                        call new_line  
                        
                        
                        
                        ;Printing the score percentage
                        mov al,bl
                        
                        mov ah,0
                        mov dl,10
                        div dl
                        
                        
                        mov bl,al
                        mov bh,ah
                        
                        mov dl,bl        
                        add dl,30h
                        mov ah,2
                        int 21h
                        mov dl,bh 
                        add dl,30h
                        int 21h
                          ; printing percentage sign
                        mov dl,25h
                        int 21h
                        
                                                
                                                
                        
                        call new_line
                        lea dx,Performance
                        mov ah,9
                        int 21h
                        call new_line
                        
                        
                        mov ax,0
                        mov bx,0
                        mov cx,0
                        mov dx,0
                        
                        mov si,0
                        mov dl,given_answers[si]
                        add cl,dl                      ;CL is History
                        
                        mov si,1
                        mov dl,given_answers[si]
                        add ch,dl                      ;CH is science
                        
                        mov si,2
                        mov dl,given_answers[si]       ;BL is World Capitals
                        add bl,dl


                        mov si,3
                        mov dl,given_answers[si]       ; BH is sports
                        add bh,dl
                        
                        
                        
                        mov si,4
                        mov dl,given_answers[si]
                        add bl,dl
                        
                        
                        
                        
                        
                        mov si,5
                        mov dl,given_answers[si]
                        add ch,dl
                        
                        
                        
                        
                        
                        mov si,6
                        mov dl,given_answers[si]
                        add bh,dl
                        
                        
                        
                        mov si,7
                        mov dl,given_answers[si]
                        add bl,dl
                        
                        
                        
                        
                        mov si,8
                        mov dl,given_answers[si]
                        add ch,dl
                        
                        
                        
                        mov si,9
                        mov dl,given_answers[si]
                        add cl,dl  
                        
                        
                        
                        
                        
                        cmp cl,1
                        jl Poor_History
                        jmp Good_History
                        Next_1:
                        
                        cmp ch,1
                        jle Poor_Science
                        jmp Good_Science
                        Next_2:
                        
                        cmp bl,1
                        jle Poor_World_Capitals
                        jmp Good_World_Capitals
                        Next_3:
                        
                        cmp bh,1
                        jl Poor_Sports
                        jmp Good_Sports
                        Next_4:
                        jmp Exit
                        
                        
                        
                        
                        Poor_History:
                            lea dx,History_bad
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_1
                            
                            
                        Good_History:
                            lea dx,History_good
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_1 
                            
                            
                            
                       Poor_Science:
                            lea dx,Science_bad
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_2
                            
                            
                        Good_Science:
                            lea dx,Science_good
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_2
                            
                            
                            
                            
                            
                            
                            
                        Poor_World_Capitals:
                            lea dx,WorldCapitals_bad
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_3
                            
                            
                        Good_World_Capitals:
                            lea dx,WorldCapitals_good
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_3
                            
                            
                            
                       Poor_Sports:
                            lea dx,Sports_bad
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_4
                            
                            
                        Good_Sports:
                            lea dx,Sports_good
                            mov ah,9
                            int 21h
                            call new_line
                            jmp Next_4
                            
                            
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        Full_Marks:   
                            lea dx, Achieved
                            mov ah,9
                            int 21h
                            call new_line
                            
                            
                            mov dx,1 
                            add dx,30h
                            mov ah,2
                            int 21h
                            mov dx,0
                            add dx,30h
                            int 21h 
                            int 21h
                            mov dx,25h
                            int 21h
                            call new_line
                            
                            lea dx, Best_Comment
                            mov ah,9
                            int 21h   
                            call new_line
                            jmp Exit
                            
                            
                            
                        
   
   
   
   
    Exit: 
        lea dx,Final_Comments
        mov ah,9
        int 21h
        call new_line
        mov ah,1
        int 21h
        cmp al, 52h
        call new_line
        je  Begin
        
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h   
    
    
; This function calculate a random number and stores it in DL register
; We need to keep the upper bound in BL
; and the lower bound in BH before calling this function
get_random_number PROC
    ; function prologue
    push bp
    push ax
    push bx
    push cx
    
    mov bp, sp

    ; function body
    mov ah, 2Ch ; DOS function to get a random character
    int 21h     ;al has the random character
     

   ; To calculate the random number within the given range
    ; random number = (rand_char mod (upper_bound - lower_bound + 1)) + lower_bound
    sub bl, bh ; (upper_bound - lower_bound)
    add bl, 1 ; (upper_bound - rand_char + 1)
    mov ah,0
    mov al,dl
    div bl
    mov al,ah       ; ah has the mod result
    mov ah,0
    add al,bh       ;  result + lower_bound
    mov dl,al       ; DL has the final answer
    
    
    

    ; function epilogue 
    
    pop cx
    pop bx
    pop ax
    pop bp
    ret ; return from function
get_random_number ENDP   


new_line PROC
    ; function prologue
    push bp   
    push ax
    push bx
    push cx
    push dx
    mov bp, sp

    
    
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h 
    
    
    

    ; function epilogue
    pop dx
    pop cx
    pop bx
    pop ax    
    pop bp
    ret ; return from function
new_line ENDP  
    
    
    





run_evaluation PROC
    ; function prologue
    push bp
    push ax
    push bx
    push cx
    
    mov bp, sp


                   
                  
                   


 
                   
                   
                   
                   
                   ; setting up di register to point the the index of that question
                   mov bx,0
                   mov al,2
                   mul dl
                   mov di,ax
                   mov cl,dl      
                   cmp si,9
                   je Print_10
                   
                   
                   ;Printing question number
                   mov dx,si 
                   add dx,31h
                   mov ah,2
                   int 21h 
                   Here:
                   
                   
                   ;Printing question and options
                   mov dx,2Eh
                   int 21h
                   mov dx, question[di]
                   mov ah,9
                   int 21h 
                   call new_line 
                   mov dx, options[di]
                   int 21h 
                   call new_line
                   
                   
                   
                   ;Grab the answer from user
                   lea dx,Answer
                   mov ah,9
                   int 21h
                   mov ah,1
                   int 21h ; AL now has the answer from user
                   sub al,41h 
                   mov ah,0     
                   mov ch,0
                   mov di,cx
                   mov bl, correct_answers[di] 
                   mov bh,0
                   cmp bx,ax
                   je Correct_0
                   jne Incorrect_0
                   
                   
                   
                   
                   Correct_0:
                        ; Update weight variable
                        mov bx,total_weight
                        mov cl,weights[di]
                        mov ch,0
                        add bx,cx
                        mov total_weight,bx
                        
                        ; Update total_score
                        mov bx,total_score
                        add cx,bx
                        mov total_score,cx
                        
                        mov given_answers[si],1 
                        
                        call new_line
                        
                        ;Printing the statements of congratulations
                        mov ah,9
                        lea dx,now_correct
                        int 21h  
                        call new_line
                        mov ah,9
                        lea dx,continue
                        int 21h
                        mov ah,1
                        int 21h
                        call new_line
                        jmp Exit_session_0
                        
                        
                        
                   Print_10: 
                    mov dx,1 
                    add dx,30h
                    mov ah,2
                    int 21h
                    mov dx,0
                    add dx,30h
                    int 21h
                    jmp Here
                        
                              
                        
                        
                        
                        
                   Incorrect_0:
                        mov bx,total_weight
                        mov cl,weights[di]
                        mov ch,0
                        add bx,cx
                        mov total_weight,bx
                   
                        
                        
                        call new_line
                        mov ah,9
                        lea dx,now_wrong
                        int 21h  
                        call new_line
                        mov ah,9
                        lea dx,continue
                        int 21h
                        mov ah,1
                        int 21h
                        call new_line
                        jmp Exit_session_0                        
                        
                   
                   
                   
                   
                   Exit_session_0:
                        mov ax,0
                        mov bx,0
                        mov cx,0
                        mov dx,0
                        mov di,0
                   
                   
                        inc si    
    
    
    

    ; function epilogue 
    
    pop cx
    pop bx
    pop ax
    pop bp
    ret ; return from function
run_evaluation ENDP   
    
    
    
    
    
    
    
    
     
ends

end start ; set entry point and stop the assembler.