class UserNameValidator < ActiveModel::EachValidator
  def validate_each(rec, attr, value)
    name = value

    rec.errors.add(attr, "already exists") if User.find_by_name(name).present?
    rec.errors.add(attr, "must be 2 to 100 characters long") if !name.length.between?(2, 100)
    rec.errors.add(attr, "cannot have whitespace or colons") if name =~ /[[:space:]]|:/
    rec.errors.add(attr, "cannot begin or end with an underscore") if name =~ /\A_|_\z/
    rec.errors.add(attr, "is not allowed") if name =~ Regexp.union(Danbooru.config.user_name_blacklist)
  end
end
