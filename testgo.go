package main

import "fmt"

type Student struct {
	age  int
	name string
}

func (student *Student) sing(lyrics string) {
	fmt.Printf("student: %s sing: %s\n", student.name, lyrics)
}

func main() {
	fmt.Println("Hello world!")
	fmt.Print("heeh")
	fmt.Printf("Good Morning!")
	s := Student{10, "Tom"}
	s.sing("hehehah")

}
