# Preview all emails at http://localhost:3000/rails/mailers/statistics_mailer
class StatisticsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/statistics_mailer/statistics_email
  def statistics_email
    StatisticsMailer.with(
      email_details: {
        user_name: 'Justin',
        email: 'justin@example.com',
        expos: [
          {
            name: 'Expo 1',
            total_likes: 1,
            total_views: 2,
            total_comments: 3,
            last_likes: 1,
            last_comments:
              [
                { user_login: 'ne_justin',
                  text: 'nopm',
                  likes_count: 9999,
                  created_at: 'v4epa' }
              ]
          }
        ]
      }
    ).statistics_email
  end

end
