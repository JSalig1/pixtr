class Charge
  AMOUNT = 2000
  DESCRIPTION = 'Pixtr Account Upgrade'

  def initialize(user, token)
    @user = user
    @token = token
  end

  def process

    customer = create_customer
    create_charge customer
    user.update_attribute(:customer_id, customer.id)
  end

  private

  attr_reader :user, :token

  def create_customer
    Stripe::Customer.create(
      :email => user.email,
      :card  => token
    )
  end

  def create_charge(customer)
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => Charge::AMOUNT,
      :description => Charge::DESCRIPTION,
      :currency    => 'usd'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end
end
