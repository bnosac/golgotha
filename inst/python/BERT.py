from transformers import *
import torch
# Transformers has a unified API
# for 10 transformer architectures and 30 pretrained weights.
#            Architecture| Model          | Tokenizer          | Pretrained weights shortcut
MODELS = {    'BERT':          (BertModel,       BertTokenizer,       'bert-base-uncased'),
              'GTP':           (OpenAIGPTModel,  OpenAIGPTTokenizer,  'openai-gpt'),
              'GTP-2':         (GPT2Model,       GPT2Tokenizer,       'gpt2'),
              'CTRL':          (CTRLModel,       CTRLTokenizer,       'ctrl'),
              'Transformer-XL':(TransfoXLModel,  TransfoXLTokenizer,  'transfo-xl-wt103'),
              'XLNet':         (XLNetModel,      XLNetTokenizer,      'xlnet-base-cased'),
              'XLM':           (XLMModel,        XLMTokenizer,        'xlm-mlm-enfr-1024'),
              'DistilBERT':    (DistilBertModel, DistilBertTokenizer, 'distilbert-base-cased'),
              'RoBERTa':       (RobertaModel,    RobertaTokenizer,    'roberta-base'),
              'XLM-RoBERTa':   (XLMRobertaModel, XLMRobertaTokenizer, 'xlm-roberta-base')
         }

class Embedder():
	def __init__(self, path = None, architecture="BERT"):
		model_class, tokenizer_class, pretrained_weights = MODELS[architecture]
		# load pretrained model/tokenizer
		self.model = model_class.from_pretrained(path)
		self.tokenizer = tokenizer_class.from_pretrained(path)
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
		
class DistilBertEmbedder():
	def __init__(self, path = None):
		self.model = DistilBertModel.from_pretrained(path)
		self.tokenizer = DistilBertTokenizer.from_pretrained(path)
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
		
def download(model_name = "bert-base-multilingual-uncased", path = None, architecture="BERT"):
	model_class, tokenizer_class, pretrained_weights = MODELS[architecture]
	# load pretrained model/tokenizer
	tokenizer = tokenizer_class.from_pretrained(pretrained_model_name_or_path = model_name)
	model = model_class.from_pretrained(pretrained_model_name_or_path = model_name, output_hidden_states = True, output_attentions = False)
	tokenizer.save_pretrained(path)
	model.save_pretrained(path)
	return(path)