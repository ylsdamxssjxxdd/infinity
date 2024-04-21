import openai

def stream_Response(messages: list):
    client = openai.OpenAI(
        base_url="http://localhost:8080/v1", # "http://<Your api-server IP>:port"
        api_key = "sk-no-key-required"
    )

    # 流式响应
    stream = client.chat.completions.create(
        model='gpt-3.5-turbo',	# 这里可以按照自己需求修改
        messages=messages,
        stream=True,
    )
    
    for chunk in stream:
        print(chunk.choices[0].delta.content)


test_messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "爸爸妈妈可以结婚吗?"}
]
stream_Response(test_messages)
