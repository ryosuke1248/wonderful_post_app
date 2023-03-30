MessagesController < BaseController
  def update
    # Some business logic

    return redirect_to:index, notice: t(".notice") if @resource.save
    render :edit, alert: t(".alert")
  end
 end