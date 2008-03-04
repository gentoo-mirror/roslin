kadu-module_spec_clean_nonmod()
{
	grep "^MODULE_" ${NAME}/spec > ${NAME}/spec.new
	mv ${NAME}/spec.new ${NAME}/spec
}

kadu-module_spec_remove()
{
	sed -i -e "s%^MODULE_${1}=.*%%g" ${NAME}/spec
}
