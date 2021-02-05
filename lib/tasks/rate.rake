namespace :rate do
    task :update do
        Chance.all.find_each do |chance|
            chance.calc!
        end
    end
end
