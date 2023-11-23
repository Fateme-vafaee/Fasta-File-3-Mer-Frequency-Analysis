#install.packages ("seqinr")
#install.packages ("ggplot2")


  #Preprocess
  #Load Data
    library(ggplot2)
    library ("seqinr")
    library("stringr")
    dir=getwd()
    setwd(dir)
  DNA_Seq=read.fasta("sequence.fasta",as.string = TRUE,seqtype = "DNA",seqonly=TRUE)[[1]]
  Three_meres=c("AAA","AAC","AAT","AAG","CAT","CAC","CAG","CAA","GAG","GAC","GAT","GAA","TAA","TAC","TAT","TAG",
    "ACC","ACA","ACT","ACG","CCA","CCT","CCC","CCG","GCA","GCC","GCT","GCG", "TCA","TCT","TCG","TCC",
    "ATT","ATC","ATA","ATG","CTC","CTG","CTA","CTT","TTT","TTA","TTC","TTG","TGG","TGA","TGC","TGT",
    "AGG","AGA","AGC","AGT","CGA","CGC","CGG","CGT","GGG","GGA","GGC","GGT","GTA","GTC","GTG","GTT")
  
  
  #Main: find and count the subseq in DNA
  
    #initial Value
  
    DNA_Length=str_length(DNA_Seq)
    result=vector("integer",64)
    
    #Counting process
    for(j in 1:64)
    {
      subseq=Three_meres[j]
      Counter=0
      subseq_Length=3
      for(i in 1:(DNA_Length-2))
      {
        temp=substr(DNA_Seq,i,subseq_Length)
        if(temp==subseq)
          Counter=Counter+1
        subseq_Length=subseq_Length+1
      }
      
      result[j]=Counter
    }
  # Plot
    clr=c(rep("#f9844a",16),rep("#f9c74f",16),rep("#90be6d",16),rep("#43aa8b",16))
    #HClr=c(rep("#343a40",16),rep("#e63946",16),rep("#343a40",16),rep("#e63946",16))
    dt=data.frame(Three_mere=Three_meres,count=result)
    dt$Three_mere=factor(dt$Three_mere,levels = dt$Three_mere)
    pl=ggplot(data=dt, aes(x = Three_mere,y = count)) +
      geom_bar(stat="identity",fill = clr)+
      theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
  
print(pl)

