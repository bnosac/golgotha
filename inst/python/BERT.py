from transformers import *
import torch
# Transformers has a unified API
# for 10 transformer architectures and 30 pretrained weights.
#            Architecture      | Model          | Tokenizer          
MODELS = {    'BERT':          (BertModel,       BertTokenizer),
              'GPT':           (OpenAIGPTModel,  OpenAIGPTTokenizer),
              'GPT-2':         (GPT2Model,       GPT2Tokenizer),
              'CTRL':          (CTRLModel,       CTRLTokenizer),
              'Transformer-XL':(TransfoXLModel,  TransfoXLTokenizer),
              'XLNet':         (XLNetModel,      XLNetTokenizer),
              'XLM':           (XLMModel,        XLMTokenizer),
              'DistilBERT':    (DistilBertModel, DistilBertTokenizer),
              'RoBERTa':       (RobertaModel,    RobertaTokenizer),
              'XLM-RoBERTa':   (XLMRobertaModel, XLMRobertaTokenizer),
              'GPT-2-LMHead':  (GPT2LMHeadModel, GPT2Tokenizer)
         }

class Embedder():
	def __init__(self, path = None, architecture = "BERT"):
		model_class, tokenizer_class = MODELS[architecture]
		self.model = model_class.from_pretrained(path)
		self.tokenizer = tokenizer_class.from_pretrained(path)
		self.nlp_feature_extraction = pipeline("feature-extraction", model = self.model, tokenizer = self.tokenizer)
	def tokenize(self, text):
		output = self.tokenizer.tokenize(text)
		return(output)
	def embed_tokens(self, text):
		output = self.nlp_feature_extraction(text)
		return(output)
	def generate(self, text, max_length = 50):
	  input_ids = self.tokenizer.encode(text, return_tensors="pt")
	  generated = self.model.generate(input_ids, max_length = max_length)
	  newtext = self.tokenizer.decode(generated.tolist()[0])
	  return(newtext)
	def embed_sentence(self, text, max_length = 512):
		input_ids = self.tokenizer.encode(text, add_special_tokens = True, max_length = max_length, return_tensors = 'pt')		
		with torch.no_grad():
			output_tuple = self.model(input_ids)
  		
		output = output_tuple[0].squeeze()
		output = output.mean(dim = 0)
		output = output.numpy()
		return(output)
		
def download(model_name = "bert-base-multilingual-uncased", path = None, architecture = "BERT"):
	model_class, tokenizer_class = MODELS[architecture]
	# load pretrained model/tokenizer
	tokenizer = tokenizer_class.from_pretrained(pretrained_model_name_or_path = model_name)
	model = model_class.from_pretrained(pretrained_model_name_or_path = model_name, output_hidden_states = True, output_attentions = False)
	# save them to disk
	tokenizer.save_pretrained(path)
	model.save_pretrained(path)
	return(path)
