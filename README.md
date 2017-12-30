# Vote

mix phx.new vote
cd vote
mix ecto.create
mix phx.server
http://localhost:4000

mix phx.gen.html User Entry entrys name:string count:integer
lib/vote_web/router.exの20行目に『resources "/entrys", EntryController』を追加
mix ecto.migrate
mix phx.server
http://localhost:4000/vote
