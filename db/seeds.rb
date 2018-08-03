# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Agent.destroy_all
Region.destroy_all
Industry.destroy_all
Lead.destroy_all


def main
  make_region
  make_industry
  make_users
  make_admin
end


def make_users
  Agent.create(name: "Karl", manager: false, password: 'password', region_id: @region.id)
  Agent.create(name: "Almir", manager: false, password: 'password', region_id: @region.id)
end

def make_admin
  Agent.create(name: "KTA", manager: true, password: 'password', region_id: @region.id)
end

def make_region
  @region = Region.create(name: 'NY')
end

def make_industry
  @industry = Industry.create(name: 'Finance')
end

main
