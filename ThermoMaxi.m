clc
clear all
close all
format short

global Filename n M1 M2 M3 R  CaseNo CompMatrix TypeEff SpType Law

Filename='ThermoMaxi.xlsx';
M1 = xlsread(Filename,1);
M2 = xlsread(Filename,2);
M3 = xlsread(Filename,3);
R=8.314;%J/K.mol,Rydberg Constant

disp('Please Enter Case number; for BubP 1,for DewP 2,for BubT 3,for DewT 4,for FlashTP 5');
CaseNo=input('Case Number= ');%Global variable to set number of case
disp('Please Enter number of species');
n=input('Number of species= ');%Global variable to set number of species in system
SpType=zeros(1,n);%Global variable to set type of species in the system
disp('Acetone(1),Methanol(2),Water(3),MethylAcetate(4),Benzene(5)');
for a=1:1:n
disp(num2str(a,'Please choose species %.f with respect to its number and enter its number'));
SpType(1,a)=input(num2str(a,'Species %.f is = '));
end

disp('For Temperature/Pressure Effect calculations please enter 1, for Composition Effect calculation please enter 2');
TypeEff=input('I want calculation = ');  %A global variable to determine desired effect type whether Temperature/Pressure effect or Composition effect
if TypeEff==1 
    T=zeros(1,3);
    P=zeros(1,3);
    if CaseNo==1 || CaseNo==2
        [T,CompMatrix]=TPeff(CaseNo,n);
    elseif CaseNo==3 || CaseNo==4 || CaseNo==5
        [P,CompMatrix]=TPeff(CaseNo,n);
    end
elseif TypeEff==2
     if CaseNo==1 || CaseNo==2
        [T,CompMatrix]=CompEff(CaseNo,n);
    elseif CaseNo==3 || CaseNo==4 || CaseNo==5
        [P,CompMatrix]=CompEff(CaseNo,n);
    end
end
%A loop to determine whether given fraction inputs are realistic
    if TypeEff==2
        for row=1:1:3
        A=sum(CompMatrix(row,:));
            for i=1:1:n
                if  (CompMatrix(row,i)>=1 || CompMatrix(row,i)<=0 || A>1)
                    disp('WARNING UNREALISTIC ENTRY PLEASE TRY AGAIN ThNX');
                    return;
                end
            end
        end
    elseif TypeEff==1
        A=sum(CompMatrix);
        for i=1:1:n
            if  (CompMatrix(1,i)>=1 || CompMatrix(1,i)<=0 || A>1)
                disp('WARNING UNREALISTIC ENTRY PLEASE TRY AGAIN ThNX');
            return;
            end   
        end   
    end
 
        

clc
%A loop to print desired outputs by given inputs
if CaseNo==1 %Bubble Pressure
    if TypeEff==1 %T/P effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp('Raoultz Law');
            elseif Law==2
                disp('Modified Raoultz Law');
            else
                disp('GammaPhi Method');
            end
            for i=1:1:3
                BubP=BubbleP(CompMatrix,T(1,i));
                disp(num2str(T(1,i),'The Bubble Pressure at %.1f Celcius is'));
                disp(num2str(BubP,'%.3f kPa'));
            end
        end
    elseif TypeEff==2 %Composition effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp(num2str(T,'Raoultz Law Calculations at %.1f Celcius'));
            elseif Law==2
                disp(num2str(T,'Modified Raoultz Law Calculations at %.1f Celcius'));
            else
                disp(num2str(T,'GammaPhi Calculations at %.1f Celcius'));
            end
            for i=1:1:3
                Composition=CompMatrix(i,:);
                disp(num2str(i,'The Bubble Pressure at composition %.f'));
                BubP=BubbleP(Composition,T);
                disp(num2str(BubP,'%.3f kPa'));
            end
        end            
    end
elseif CaseNo==2 %Dew Pressure
    if TypeEff==1 %T/P effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp('Raoultz Law');
            elseif Law==2
                disp('Modified Raoultz Law');
            else
                disp('GammaPhi Method');
            end
            for i=1:1:3
                DewwP=DewP(CompMatrix,T(1,i));
                disp(num2str(T(1,i),'The Dew Pressure at %.1f Celcius is'));
                disp(num2str(DewwP,'%.3f kPa'));
            end
        end
    elseif TypeEff==2 %composition effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp(num2str(T,'Raoultz Law Calculations at %.1f Celcius'));
            elseif Law==2
                disp(num2str(T,'Modified Raoultz Law Calculations at %.1f Celcius'));
            else
                disp(num2str(T,'GammaPhi Calculations at %.1f Celcius'));
            end
            for i=1:1:3
                Composition=CompMatrix(i,:);
                disp(num2str(i,'The Dew Pressure at composition %.f'));
                DewwP=DewP(Composition,T);
                disp(num2str(DewwP,'%.3f kPa'));
            end
        end            
    end
elseif CaseNo==3 %Bubble Temperature
    if TypeEff==1 %T/P effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp('Raoultz Law');
            elseif Law==2
                disp('Modified Raoultz Law');
            else
                disp('GammaPhi Method');
            end
            for i=1:1:3
                BubT=BubbleT(CompMatrix,P(1,i));
                disp(num2str(P(1,i),'The Bubble Temperature at %.2f kPa is'));
                disp(num2str(BubT,'%.2f Celcius'));
            end
        end
    elseif TypeEff==2 %composition effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp(num2str(P,'Raoultz Law Calculations at %.2f kPa'));
            elseif Law==2
                disp(num2str(P,'Modified Raoultz Law Calculations at %.2f kPa'));
            else
                disp(num2str(P,'GammaPhi Calculations at %.2f kPa'));
            end
            for i=1:1:3
                Composition=CompMatrix(i,:);
                disp(num2str(i,'The Bubble Temperature at composition %.f'));
                BubT=BubbleT(Composition,P);
                disp(num2str(BubT,'%.2f Celcius'));
            end
        end            
    end
elseif CaseNo==4 %Dew Temperature  
    if TypeEff==1 %T/P effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp('Raoultz Law');
            elseif Law==2
                disp('Modified Raoultz Law');
            else
                disp('GammaPhi Method');
            end
            for i=1:1:3
                DewwT=DewT(CompMatrix,P(1,i));
                disp(num2str(P(1,i),'The Dew Temperature at %.2f kPa is'));
                disp(num2str(DewwT,'%.2f Celcius'));
            end
        end
    elseif TypeEff==2 %composition effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp(num2str(P,'Raoultz Law Calculations at %.2f kPa'));
            elseif Law==2
                disp(num2str(P,'Modified Raoultz Law Calculations at %.2f kPa'));
            else
                disp(num2str(P,'GammaPhi Calculations at %.2f kPa'));
            end
            for i=1:1:3
                Composition=CompMatrix(i,:);
                disp(num2str(i,'The Dew Temperature at composition %.f'));
                DewwT=DewT(Composition,P);
                disp(num2str(DewwT,'%.2f Celcius'));
            end
        end            
    end
elseif CaseNo==5 %Flash calculations
    if TypeEff==1 %T/P effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp('Raoultz Law');
            elseif Law==2
                disp('Modified Raoultz Law');
            else
                disp('GammaPhi Method');
            end
            for i=1:1:3
                VapFrac=FlashCalc(CompMatrix,P(1,i));
                disp(num2str(P(1,i),'The overall Vapor(V) fraction at %.2f kPa is'));
                disp(num2str(VapFrac,'%.3f'));
            end
        end
    elseif TypeEff==2 %Composition effect
        for k=1:1:3
            Law=k;
            if Law==1
                disp(num2str(P,'Raoultz Law Calculations at %.2f kPa'));
            elseif Law==2
                disp(num2str(P,'Modified Raultz Law Calculations at %.2f kPa'));
            else
                disp(num2str(P,'GammaPhi Calculations at %.2f kPa'));
            end
            for i=1:1:3
                Composition=CompMatrix(i,:);
                VapFrac=FlashCalc(Composition,P);
                disp(num2str(i,'The overall Vapor(V) fraction at composition %.f is'));
                disp(num2str(VapFrac,'%.3f'));
            end
        end            
    end
end


