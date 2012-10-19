module UsersHelper
  def total_debt(user)
    debt = @user.debts.collect {|user| @user.owes(user) - user.owes(@user)}.inject{:+}
    if debt >= 0.01
      "You owe your friends $#{debt}"
    elsif debt <= 0.01
      "Your friends owe you $#{debt * -1}"
    else
      "You have no outstanding debts"
    end
  end
end
