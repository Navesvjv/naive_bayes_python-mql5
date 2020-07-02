#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

string A = "111";
string B = "222";
string C = "333";
string D = "444";
string E = "555";
string F = "666";
string G = "777";
string H = "888";
string I = "999";
string J = "101";

void OnStart(){
   string dados;
   int qtdCandles = Bars(_Symbol, _Period) - 20;

   int handle = FileOpen("Data//NaiveBayes"+_Symbol+"_"+EnumToString(_Period)+".csv", FILE_READ|FILE_WRITE|FILE_CSV|FILE_ANSI);
   if(handle != INVALID_HANDLE){
   
      FileWrite(handle, "A;DifOpenClose_Open;DifHighLow_Open;TypeCandle;Gap;Tagert");
      
      for(int i = 1; i < qtdCandles; i++){
         dados = "";
         
         double open = iOpen(_Symbol, _Period, i);
         double openAnt = iOpen(_Symbol, _Period, i+1);
         double close = iClose(_Symbol, _Period, i);
         double closeAnt = iClose(_Symbol, _Period, i+1);
         
         double highAnt = iHigh(_Symbol, _Period, i+1);
         double lowAnt = iLow(_Symbol, _Period, i+1);
         
         if(MathAbs(lowAnt - closeAnt) > MathAbs(highAnt - open)) dados += I + ";";
         else dados += J + ";";
         
         if(MathAbs(closeAnt - open) > MathAbs(openAnt - open)) dados += G + ";";
         else dados += H + ";";
         
         if(MathAbs(lowAnt - open) > MathAbs(highAnt - open)) dados += E + ";";
         else dados += F + ";";
                  
         if(openAnt > closeAnt) dados += A + ";";
         else dados += B + ";";
         
         if(closeAnt > open) dados += C + ";";
         else dados += D + ";";
         
         if(open > close) dados += "0";
         else dados += "1";      
              
         FileWrite(handle, dados);
      }
      
      FileClose(handle);
   }else{
      Print("Errado!");
   }   
}
