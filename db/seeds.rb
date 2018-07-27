# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
DATA = {
  :agent_keys =>
    ["name", "password"],
  :agents => [
    ["Karl Almir", "password"],
    ["Agent1", "password"],
  ],
  :admins => [
    "KTA"
  ]
}

def main
  make_users
  make_admin
end

def make_users
  DATA[:agents].each do |agent|
    new_agent = Agent.new
    agent.each_with_index do |attribute, i|
      new_agent.send(DATA[:agent_keys][i]+"=", attribute)
    end
    new_agent.save
  end
end

def make_admin
  DATA[:admins].each do |name|
    Agent.create(name: name, admin: true, password: 'password')
  end
end
