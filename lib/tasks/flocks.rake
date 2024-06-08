namespace :util do
#   task fix_previous_batches: :environment do
#   ## selct * from incomes i join batchs b on b.id = i.batch_id
#   correctBatch = Batch.where(batches.batch_number = 20220703)

#   list = Income.includes(:batch).where(batch.id = 20220703)
#   list.each do |item|
#     item.batch_id = correctBatch.id
#     # item.save
#     puts item
#   end
# end

  task fix_previous_batches: :environment do
    ## select * from incomes i join batches b on b.id = i.batch_id
    
    list = Expense.includes(:batch).where(batch_id: 138)
    my_list = Expense.includes(:batch).where(batch_id: 139)
    list_new = Expense.includes(:batch).where(batch_id: 140)
    list1 = Expense.includes(:batch).where(batch_id: 141)
    my_list1 = Expense.includes(:batch).where(batch_id: 142)
    # list_new1 = Expense.includes(:batch).where(batch_id: 74)

    list.each do |item|
      item.update_attribute(:batch_id, 132)
    end  

    my_list.each do |item|
      item.update_attribute(:batch_id, 133)
    end  

    list_new.each do |item|
      item.update_attribute(:batch_id, 134)
    end  

    list1.each do |item|
      item.update_attribute(:batch_id, 135)
    end  

    my_list1.each do |item|
      item.update_attribute(:batch_id, 136)
    end  

    # list_new1.each do |item|
    #   item.update_attribute(:batch_id, 137)
    # end  

    # my_list.each do |mine|
    #   mine.update(attribute(:batch_id, 127))
    # end
    
    # shapiro = Batch.find_by(batch_no: 20230324)
    # puts shapiro.id

    # shapiro_new = Batch.find_by(batch_no: 20230326)
    # puts shapiro_new.id

    # shapiro_newer = Batch.find_by(batch_no: 20230627)
    # puts shapiro_newer.id
  end

end
