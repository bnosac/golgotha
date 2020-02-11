from transformers import BertModel, BertTokenizer, pipeline
import torch
class Embedder():
	def __init__(self, path = None):
		self.model = BertModel.from_pretrained(path)
		self.tokenizer = BertTokenizer.from_pretrained(path)
		self.nlp_feature_extraction = pipeline("feature-extraction", model = self.model, tokenizer = self.tokenizer)
	def tokenize(self, text):
		output = self.tokenizer.tokenize(text)
		return(output)
	def embed_tokens(self, text):
		output = self.nlp_feature_extraction(text)
		return(output)
	def embed_sentence(self, text, max_length = 512):
		input_ids = self.tokenizer.encode(text, add_special_tokens = True, max_length = max_length, return_tensors = 'pt')		
		with torch.no_grad():
			output_tuple = self.model(input_ids)
		
		output = output_tuple[0].squeeze()
		output = output.mean(dim = 0)
		output = output.numpy()
		return(output)
		
def download(model_name = "bert-base-multilingual-uncased", path = None):
	tokenizer = BertTokenizer.from_pretrained(pretrained_model_name_or_path = model_name)
	model = BertModel.from_pretrained(pretrained_model_name_or_path = model_name, output_hidden_states = True, output_attentions = False)
	tokenizer.save_pretrained(path)
	model.save_pretrained(path)
	return(path)

