Note.delete_all
User.delete_all
Category.delete_all

user1 = User.create(username:"testuno",password:"asdfg")
user2 = User.create(username:"testdos",password:"asdfg")

note1 = Note.create(user_id:user1.id, title:"first note",content:"content of my first note")
note2 = Note.create(user_id:user1.id, title:"second note", content:"content of the second note")

Category.create([
    {name:"Study"},
    {name:"Work"},
    {name:"Shopping"},
    {name:"Gym"}
])