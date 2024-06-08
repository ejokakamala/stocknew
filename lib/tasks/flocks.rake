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
    ## selct * from incomes i join batchs b on b.id = i.batch_id
    correctBatch = Batch.where(batch_no = 20220703)
    list = Income.includes(:batch).where(id = 1312)
    list.each do |item|
      item.batch_id = correctBatch.id
      item.save
      puts item
    end
  end
end

#rake util:fix_previous_baches RAILS_ENV=production