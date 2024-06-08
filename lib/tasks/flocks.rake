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
    
    list = Income.includes(:batch).where(batch_id: 75)
    my_list = Income.includes(:batch).where(batch_id: 76)
    list_new = Income.includes(:batch).where(batch_id: 78)

    list.each do |item|
      item.update_attribute(:batch_id, 138)
    end  

    my_list.each do |item|
      item.update_attribute(:batch_id, 139)
    end  

    list_new.each do |item|
      item.update_attribute(:batch_id, 140)
    end  

    # my_list.each do |mine|
    #   mine.update(attribute(:batch_id, 127))
    # end
    
    shapiro = Batch.find_by(batch_no: 20240235)
    puts shapiro.id

    shapiro_new = Batch.find_by(batch_no: 20231233)
    puts shapiro_new.id

    # shapiro_newer = Batch.find_by(batch_no: 20240334)
    # puts shapiro_newer.id
  end

end
