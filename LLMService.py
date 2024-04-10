from typing import List, Optional
from langchain.llms.base import LLM
from langchain.llms.utils import enforce_stop_tokens
from transformers import AutoModel, AutoTokenizer
import torch

class LLMService(LLM):
    max_token: int = 10000
    temperature: float = 0.1
    top_p = 0.9
    history = []
    tokenizer: object = None
    model: object = None

    def __init__(self):
        super().__init__()

    @property
    def _llm_type(self) -> str:
        return "LLM"

    def _call(self,prompt: str,stop: Optional[List[str]] = None) -> str:
        response, updated_history = self.model.chat(
            self.tokenizer,
            prompt,
            history=self.history,
            max_length=self.max_token,
            temperature=self.temperature,
        )
        if stop is not None:
            response = enforce_stop_tokens(response, stop)
        # self.history = self.history + [[None, response]]
        self.history = updated_history
        return response

    def load_model(self, model_name_or_path: str = "model_path"):
        """
        加载大模型LLM
        :return:
        """
        # device_map = "auto"
        self.tokenizer = AutoTokenizer.from_pretrained(model_name_or_path,trust_remote_code=True)
        # self.model = AutoModel.from_pretrained(model_name_or_path, trust_remote_code=True,device_map=device_map).half()
        self.model = AutoModel.from_pretrained(model_name_or_path, trust_remote_code=True).half().cuda()
        self.model = self.model.eval()

    def set_parameters(self, max_token: int = None, temperature: float = None, top_p: float = None):
        if max_token is not None:
            self.max_token = max_token
        if temperature is not None:
            self.temperature = temperature
        if top_p is not None:
            self.top_p = top_p
        

if __name__ == '__main__':
    llm_service = LLMService()
    llm_service.load_model()