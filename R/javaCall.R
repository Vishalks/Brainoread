javaCall <- function(modelName, train = FALSE, test = FALSE){
  # create instance of BrainoRead class
   brObj <- .jnew("BrainoRead")

   # invoke trainAndTest method
   out <- .jcall(brObj, "I", "trainAndTest", modelName, train, test)
   return(out)
}
