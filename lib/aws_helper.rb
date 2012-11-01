module AWSHelper
  def self.upload_to_s3(type, file, path)
    
    #create file
    s3_file = AWS::S3.new(:access_key_id => ENV['S3_ACCESS_KEY'], 
                       :secret_access_key => ENV['S3_SECRET_KEY'])
                      .buckets[ENV['S3_BUCKET']]
                      .objects[path]
                      
    #write data into it
    case type
    when :image
      s3_file.write(file.to_blob)
    when :file
      s3_file.write(file.read)
    end
    
    #set permissions
    s3_file.acl = :public_read
    
    return s3_file
  end
  
  def self.delete_from_s3(path)
    s3_file = AWS::S3.new(:access_key_id => ENV['S3_ACCESS_KEY'], 
                       :secret_access_key => ENV['S3_SECRET_KEY'])
                      .buckets[ENV['S3_BUCKET']]
                      .objects[path]
    s3_file.delete
    s3_file.exists? == false
  end
  
  def self.set_read_permissions
   s3_files = AWS::S3.new(:access_key_id => ENV['S3_ACCESS_KEY'], 
                       :secret_access_key => ENV['S3_SECRET_KEY'])
                      .buckets[ENV['S3_BUCKET']]
                      .objects
   counter = 0
   s3_files.each do |f|
     f.acl = :public_read
     counter += 1
     puts "#{counter} files updated"
   end
   puts "done"
  end
  
  def self.generate_path_for
    #{}"#{Rails.env}/users/#{user.created_at.year}/#{user.created_at.month}/#{user.created_at.day}/#{user.id}/#{type.to_s}s/#{filename}"
  end
end