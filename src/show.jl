##############################################################################
#
# Basic printing of TextAnalysis types
#
##############################################################################

print(io::IOStream, d::AbstractDocument) = println(io, "A $(typeof(d))")
print(io::IOStream, crps::Corpus) = println(io, "A Corpus")

print(d::AbstractDocument) = print(OUTPUT_STREAM, d)
print(crps::Corpus) = print(OUTPUT_STREAM, crps)

show(io::IOStream, d::AbstractDocument) = println(io, "A $(typeof(d))")
show(io::IOStream, crps::Corpus) = println(io, "A Corpus")

show(d::AbstractDocument) = show(OUTPUT_STREAM, d)
show(crps::Corpus) = show(OUTPUT_STREAM, crps)

##############################################################################
#
# Pretty printing of TextAnalysis types
#
##############################################################################

function summary(d::AbstractDocument)
	o = ""
	o *= "A $(typeof(d))\n"
	o *= " * Language: $(language(d))\n"
	o *= " * Name: $(name(d))\n"
	o *= " * Author: $(author(d))\n"
	o *= " * Timestamp: $(timestamp(d))\n"
	if contains({TokenDocument, NGramDocument}, typeof(d))
		o *= " * Snippet: ***SAMPLE TEXT NOT AVAILABLE***"
	else
		sample_text = replace(text(d)[1:50], r"\s+", " ")
		o *= " * Snippet: $(sample_text)"
	end
	return o
end

function summary(crps::Corpus)
	n = length(crps.documents)
	n_s = sum(map(d -> typeof(d) == StringDocument, crps.documents))
	n_f = sum(map(d -> typeof(d) == FileDocument, crps.documents))
	n_t = sum(map(d -> typeof(d) == TokenDocument, crps.documents))
	n_ng = sum(map(d -> typeof(d) == NGramDocument, crps.documents))
	lexicon_size = 0
	print("A Corpus with $n documents:\n")
	print(" * $n_s StringDocument's\n")
	print(" * $n_f FileDocument's\n")
	print(" * $n_t TokenDocument's\n")
	print(" * $n_ng NGramDocument's\n\n")
	print("Corpus's lexicon contains $(lexicon_size) tokens\n\n")
end

##############################################################################
#
# In the REPL, show the summary by default
#
##############################################################################

repl_show(io::IO, d::AbstractDocument) = print(io, summary(d))
repl_show(io::IO, crps::Corpus) = print(io, summary(crps))
repl_show(io::IO, dtm::DocumentTermMatrix) = print(io, "A DocumentTermMatrix")