# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.present?
      can :read, Expo

      can :read, ExpoModel

      can :create, Comment
      can :read, Comment
      can :update, Comment, user_id: user.id
      can :destroy, Comment, user_id: user.id

      can :read, User
      can :update, User, id: user.id
      can :destroy, User, id: user.id

      can :create, UserExpo
      cannot :read, UserExpo
      can :update, UserExpo, user_id: user.id
      cannot :destroy, UserExpo

      can :visit, :visits_like
      can :like, :visits_like

      if user.organizer_role?
        can :create, Expo
        can :update, Expo, user_id: user.id
        can :destroy, Expo, user_id: user.id

        can :create, ExpoModel
        can :update, ExpoModel, expo: { user_id: user.id }
        can :destroy, ExpoModel, expo: { user_id: user.id }
      end

      if user.superadmin_role?
        can :crud, User
        can :crud, Expo
        can :crud, Comment
        can :crud, ExpoModel
        can :crud, UserExpo
      end
    end
  end
end
