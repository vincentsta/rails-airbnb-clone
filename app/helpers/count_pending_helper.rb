module CountPendingHelper

  def count_pending(element)
    element.select { |x| x.current_status == "pending"}.count
  end

end
