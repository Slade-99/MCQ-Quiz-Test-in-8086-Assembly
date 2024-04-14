data segment
    ; add your data here!
    
    
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

    
                                                                                                                                                                                                      
    question dw offset question1, offset question2, offset question3, offset question4, offset question5, offset question6, offset question7, offset question8, offset question9, offset question10, offset question11, offset question12, offset question13, offset question14, offset question15, offset question16, offset question17, offset question18, offset question19, offset question20


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
    
                                                                                                                                                                                                      
    options dw offset options1, offset options2, offset options3, offset options4, offset options5, offset options6, offset options7, offset options8, offset options9, offset options10, offset options11, offset options12, offset options13, offset options14, offset options15, offset options16, offset options17, offset options18, offset options19, offset options20


    correct_answers db 0,1,2,1,0,2,1,2,0,2,0,0,1,0,2,0,1,2,0,2  
    
    
    
    question_picked db 20 dup(0)  
    
   
   
    weights db  1,2,1,3,3,1,1,2,3,3,1,1,2,3,3,1,1,2,3,3    
    
    
   
   given_answers db 10 dup(0)  
   
   
   
   total_score dw 0
   
   total_weight dw 0        
   
   
   lets_begin dw "Lets Start The Quiz!$"
   enter_key dw "Press Enter to Start$"
   now_correct dw "Congrats You Answer is Correct$"
   now_wrong dw "Sorry Incorrect Answer$"
   continue dw "Press Enter to Continue$"
    
   
     History_bad dw "Poor in History$"
   History_good dw "Good in History$"
                                      
     WorldCapitals_bad dw "Poor in World Capitals$"
   WorldCapitals_good dw "Good in World Capitals$"
   
     Science_bad dw "Poor in Science$"
   Science_good dw "Good in Science$"
   
     Sports_bad dw "Poor in Sports$"
   Sports_good dw "Good in Sports$"
   
   Best_Comment dw "You have aced this quiz. Well Done!$"
    
   Final_Comments dw "Press R in your keyboard to play again or press Enter to exit$" 
   
   Achieved dw "Your Score is: $"
   
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

    ; add your code here
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
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

    
    mov ah, 2Ch ; DOS function to get a random character 
    int 21h ;
    

    ; To calculate the random number within the given range
    ; random number = (rand_char mod (upper_bound - lower_bound + 1)) + lower_bound
    sub bl, bh ; (upper_bound - rand_char)
    add bl, 1 ; (upper_bound - rand_char + 1)
    mov ah,0
    mov al,dl
    div bl
    mov al,ah     ; ah has the mod result
    mov ah,0
    add al,bh     ;  result + lower_bound
    mov dl,al     ; DL has the final answer
    
    
    

    ; function epilogue 
    
    pop cx
    pop bx
    pop ax
    pop bp
    ret ; return from function
get_random_number ENDP   



ends

end start ; set entry point and stop the assembler.