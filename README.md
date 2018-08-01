# README

This app lets different users or agents track and manage his/her leads - potential customers. An agent signs up or signs in, and then track his leads which hopefully will be converted as sales. There are CRUD funcitonalities for managing the leads. Different agents can track their respective leads but not see the leads of other agents. The agent though can see the leads in his region and the leads in a particular industry. He won’t know though who those leads belong to. If an agent signs up as a manager, the manager can see how each region is doing and how each industry is doing. He can also see how agents in his/her region are doing.

* How to use:
  1. Clone the project
  2. In your terminal:
     -type "bundle install" for gem installation
     -type "rake db:migrate"
     -rake "db:seed"
  3. Run the program. In your terminal:
     -type 'rails s'
  4. Go to localhost:3000
