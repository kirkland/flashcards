desc "Cron runs daily on heroku"

task :cron => :environment do
  Quiz.destroy_old_unfinished_quizzes
end
