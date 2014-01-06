DeepWhale::Engine.routes.draw do

	resources :teams

	resources :games

	resources :players do
		resources :stats
	end
end