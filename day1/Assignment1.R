###### 1 ########
num_vector = c(98, 82, 102,99,100)
num_vector
first_element = num_vector[1]
sprintf("First Element in Vector is %i", first_element)
first_and_fifth_element = num_vector[c(1,5)]
sprintf("First Element in Vector is %i & Fifth Element in Vector is %i", first_and_fifth_element[1], first_and_fifth_element[2])



###### 2 ########
interval_vector = seq(40,1000,10)
interval_vector
len_interval_vector = length(interval_vector)
sprintf("Length of vector is %i", len_interval_vector)



###### 3 ########
interval_vector_2 = seq(1,2500)
interval_vector_2
interval_vector_2_subset = interval_vector_2[c(1:50)]
interval_vector_2_subset



###### 4 ########
vec1 = c(3, 4, 5, 7) 
vec2 = c(6, 9, 12, 15, 18, 21)
sum_vec1_vec2 = vec1+vec2
sum_vec1_vec2
substract_vec1_vec2 = vec1-vec2
substract_vec1_vec2
sprintf("Observation : The vector with less elements repeats itself from beginning, Along with that if throws an waring 'longer object length is not a multiple of shorter object length'")



###### 5 ########
vec3 = c(34, 43, 22, 43)
vec4 = c(13, 17)
vec3*vec4



###### 6 ########
vec5 = c(1:10) 
vec6 = c(11:20) 
colBind_vec5_vec6 = cbind(vec5, vec6)
colBind_vec5_vec6
matrx1 = matrix(c(21:40), 10, 2)
matrx1
bind_Vec_matrix = cbind(colBind_vec5_vec6, matrx1)
bind_Vec_matrix



###### 7 ########
dataframe1 = data.frame(CharColumn = c('a','b','c','d','e'), NumericColumn = c(1,2,3,4,5))
dataframe1



###### 8 ########
dataframe2 = data.frame(c(1:50),c(51:100))
dataframe2
colnames(dataframe2)[1] = "column1"
colnames(dataframe2)[2] = "column2"
dataframe2
