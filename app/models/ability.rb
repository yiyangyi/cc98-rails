class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      cannot :manage, :all
      basic_ability
    elsif user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:member)     
    else
      cannot :manage, :all
      basic_ability
    end
    protected
      def basic_ability
        can :read, Topic
        can :feed, Topic
        can :node, Topic
        can :read, Reply
        can :read, Photo
        can :read, Section
        can :read, Node
        can :read, Comment
        can :preview, Note
      end
  end
end
