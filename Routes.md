                Prefix Verb   URI Pattern                                                                              Controller#Action
                        GET    /                                                                                        sessions#welcome
                 signin GET    /signin(.:format)                                                                        sessions#new
                        POST   /signin(.:format)                                                                        sessions#create
                signout POST   /signout(.:format)                                                                       sessions#destroy
                 signup GET    /signup(.:format)                                                                        agents#new
            agent_leads GET    /agents/:agent_id/leads(.:format)                                                        leads#index
         new_agent_lead GET    /agents/:agent_id/leads/new(.:format)                                                    leads#new
        edit_agent_lead GET    /agents/:agent_id/leads/:id/edit(.:format)                                               leads#edit
             agent_lead GET    /agents/:agent_id/leads/:id(.:format)                                                    leads#show
           agent_region GET    /agents/:agent_id/regions/:id(.:format)                                                  regions#show
         agent_industry GET    /agents/:agent_id/industries/:id(.:format)                                               industries#show
                  agent GET    /agents/:id(.:format)                                                                    agents#show
             industries GET    /industries(.:format)                                                                    industries#index
                        POST   /industries(.:format)                                                                    industries#create
           new_industry GET    /industries/new(.:format)                                                                industries#new
          edit_industry GET    /industries/:id/edit(.:format)                                                           industries#edit
               industry GET    /industries/:id(.:format)                                                                industries#show
                        PATCH  /industries/:id(.:format)                                                                industries#update
                        PUT    /industries/:id(.:format)                                                                industries#update
                        DELETE /industries/:id(.:format)                                                                industries#destroy
                regions GET    /regions(.:format)                                                                       regions#index
                        POST   /regions(.:format)                                                                       regions#create
             new_region GET    /regions/new(.:format)                                                                   regions#new
            edit_region GET    /regions/:id/edit(.:format)                                                              regions#edit
                 region GET    /regions/:id(.:format)                                                                   regions#show
                        PATCH  /regions/:id(.:format)                                                                   regions#update
                        PUT    /regions/:id(.:format)                                                                   regions#update
                        DELETE /regions/:id(.:format)                                                                   regions#destroy
                  leads GET    /leads(.:format)                                                                         leads#index
                        POST   /leads(.:format)                                                                         leads#create
               new_lead GET    /leads/new(.:format)                                                                     leads#new
              edit_lead GET    /leads/:id/edit(.:format)                                                                leads#edit
                   lead GET    /leads/:id(.:format)                                                                     leads#show
                        PATCH  /leads/:id(.:format)                                                                     leads#update
                        PUT    /leads/:id(.:format)                                                                     leads#update
                        DELETE /leads/:id(.:format)                                                                     leads#destroy
                 agents GET    /agents(.:format)                                                                        agents#index
                        POST   /agents(.:format)                                                                        agents#create
              new_agent GET    /agents/new(.:format)                                                                    agents#new
             edit_agent GET    /agents/:id/edit(.:format)                                                               agents#edit
                        GET    /agents/:id(.:format)                                                                    agents#show
                        PATCH  /agents/:id(.:format)                                                                    agents#update
                        PUT    /agents/:id(.:format)                                                                    agents#update
                        DELETE /agents/:id(.:format)                                                                    agents#destroy

  <div class = "container">
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <a class="navbar-brand" href="/">Home</a>
      <% if !session[:agent_id] %>
        <a class="navbar-brand" href="/signin">Sign In</a>
        <a class="navbar-brand" href="/auth/facebook'">Sign In Using Facebook</a>'
      <% end %>
      <%= link_to "Sign Out", {controller: "sessions", action: "destroy"}, class="navbar-brand" %>
    </nav>
    <br><br><br>
  </div>
