terraform {
  backend "remote" {
    organization = "starjunk"

    workspaces {
      name = "automata"
    }
  }

  required_version = "1.13.1"
}
