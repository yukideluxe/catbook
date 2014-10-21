class CatPolicy
  attr_reader :user, :cat

  def initialize(user, cat)
    @user = user
    @cat  = cat
  end

  def show?
    cat.visible || user
  end

  def update?
    user && cat.id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, cat.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user
        scope
      else
        scope.visible
      end
    end
  end
end


