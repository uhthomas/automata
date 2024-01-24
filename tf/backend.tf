terraform {
  backend "remote" {
    organization = "starjunk"

    workspaces {
      name = "automata"
    }
  }

  required_version = "1.7.1"
}
