signature Interpreter =
sig

  val evalDefs : Syntax.Pgm -> unit

  exception RunError of string*Syntax.pos

end
