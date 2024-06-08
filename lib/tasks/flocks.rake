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
    
    list = Income.includes(:batch).where(batch_id: 67)
    # # my_list = Expense.includes(:batch).where(batch_id: 60)

    list.each do |item|
      item.update_attribute(:batch_id, 132)
    end  

    # my_list.each do |mine|
    #   mine.update(attribute(:batch_id, 127))
    # end
    
    shapiro = Batch.find_by(batch_no: 20230326)
    puts shapiro.id
  end

end
